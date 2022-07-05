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

const SOLANA_DEVNET = 'https://api.devnet.solana.com';
const SOLANA_TESTNET = 'https://api.testnet.solana.com';
const SOLANA_MAINNET_BETA = 'https://api.mainnet-beta.solana.com';

app.post('/createWallet', (req, res) => {
    const { userId, walletName } = req.body

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

            // find user's wallet
            // upload a new wallet

            const newWallet = {
                walletName: walletName ?? pubKey,
                pubKey,
                mnemonicPhrase,
                privKeyArray: keypair.secretKey,
                privKey: privKeyBase58String,
                isMaster: false
            };

            

            const db = getFirestore();

            const walletRef = db.collection('wallets').doc(userId)
            await walletRef.update({
                [`wallets.${pubKey}`]: {
                    ...newWallet
                }
            })
            

            res.send({
                success: true,
                newWallet
            });

        } catch (error) {
            console.log('ERROR: ', error)
            res.send({
                success: false,
                error: error
            });
        };
        
    });
});

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
                        walletName: pubKey,
                        pubKey,
                        mnemonicPhrase,
                        privKeyArray: keypair.secretKey,
                        privKey: privKeyBase58String,
                        isMaster: true
                    },
                }
            };

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
            });
        }
        
    });

});

app.post('/checkBalance', (req, res) => {
    
    const { pubKey, network } = req.body

    if(!pubKey || !network) {
        res.send({
            success: false,
            balance: null,
            error: 'No Pub Key or Network'
        });
    }

    exec(`sh ./scripts/balance.sh ${pubKey} ${network}`, (error, stdout, stderr) => {

        if (error !== null) {
            console.log('ERROR: ', error)
            return res.send({
                success: false,
                balance: null
            });
        }

        const balance = stdout.split(' ')[0];

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
