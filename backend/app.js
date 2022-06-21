var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

const { Keypair } = require('@solana/web3.js');
const { exec } = require('child_process');
const bip39 = require('bip39')
const bs58 = require('bs58')

const { initializeApp, cert } = require("firebase-admin/app");
const { setDoc, FieldValue, getFirestore } = require("firebase-admin/firestore");
var serviceAccount = require("./service_account.json");

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.post('/createNewUser', (req, res) => {
    exec('sh ./scripts/wallet.sh', async (error, stdout, stderr) => {

        try {
            if (error !== null) {
                console.log(`exec error: ${error}`);
                throw Error(error)
            }

            const split = stdout.split('\n');
            const mnemonicPhrase = split[5];

            const seed = bip39.mnemonicToSeedSync(mnemonicPhrase, "");
            const keypair = Keypair.fromSeed(seed.slice(0, 32));

            const privKeyBase58String = bs58.encode(keypair.secretKey);
            const pubKey = keypair.publicKey.toBase58();

            const user = {
                passcode: [],
                id: `${pubKey}@occam.io`,
            };

            const wallet = {
                id: `${pubKey}@occam.io`,
                wallets: {
                    master: {
                        pubKey,
                        mnemonicPhrase,
                        privKeyArray: keypair.secretKey,
                        privKey: privKeyBase58String,
                    },
                }
            }

            const db = getFirestore();
            const batch = db.batch();
            const userDocRef = db.collection('users').doc(`${pubKey}@occam.io`);
            const walletDocRef = db.collection('wallets').doc(`${pubKey}@occam.io`);

            batch.set(userDocRef, user);
            batch.set(walletDocRef, wallet);
            await batch.commit();

            res.send({
                success: true,
                user,
                wallet
            });

        } catch (error) {
            res.send({
                success: false,
                error: error
            })
        }
        
    })

})

app.post('/checkBalance', (req, res) => {
    const { pub_key } = req.body

    exec(`sh ./scripts/balance.sh ${pub_key}`, (error, stdout, stderr) => {

        if (error !== null) {
            console.log('ERROR: ', error)
            return res.send({
                success: false,
                balance: null
            })
        }

        const balance = stdout.split(' ')[0]
        console.log('BALANCE: ', balance)

        return res.send({
            success: true,
            balance
        });
    });

});

app.listen(3000, () => {
    console.log(`Example app listening on port ${3000}`);
    initializeApp({
        credential: cert(serviceAccount)
    });
});
