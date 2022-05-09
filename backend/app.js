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

app.post('/createWallet', (req, res) => {
    const { userId, name } = req.body;
    exec('sh ./scripts/wallet.sh', (error, stdout, stderr) => {

        try {
            const split = stdout.split('\n');
            const mnemonicPhrase = split[5];

            const seed = bip39.mnemonicToSeedSync(mnemonicPhrase, "");
            const keypair = Keypair.fromSeed(seed.slice(0, 32));

            const privKeyBase58String = bs58.encode(keypair.secretKey);
            const pubKey = keypair.publicKey.toBase58();

            const data = {
                pub_key: pubKey,
                mneumonic: mnemonicPhrase,
                priv_key_array: keypair.secretKey,
                priv_key: privKeyBase58String,
                name: name
            };

            if(userId) {
                const db = getFirestore();

                db.collection('wallets').doc(userId).update({
                    wallets: FieldValue.arrayUnion(data)
                })
            }

            if (error !== null) {
                console.log(`exec error: ${error}`);
                throw Error(error)
            }

            res.send({
                success: true,
                ...data
            });

        } catch (error) {
            res.send({
                success: false,
                error: error
            })
        }

        
    })

})

app.get('/createUser', (req, res) => {
    // TODO: 
    // [ ] Add User to Firebase
    // [ ] Create Wallet and Address Book Docs
    // [ ] Create Settings Doc
});

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
