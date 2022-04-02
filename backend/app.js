var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const { Keypair } = require('@solana/web3.js');
const { exec } = require('child_process');

const { initializeApp, cert } = require("firebase-admin/app");

const { getFirestore, Timestamp, FieldValue } = require('firebase-admin/firestore');
var serviceAccount = require("./service_account.json");

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', async (req, res) => {
    const db = getFirestore()
    try {
        
        const querySnapshot = await db.collection('wallets').get();
        querySnapshot.forEach((doc) => {
            console.log(doc.id, ' => ', doc.data())
        });
    } catch(err) {
        console.log('ERROR: ', err)
    }
    // const seed = bip39
    //     .mnemonicToSeedSync(
    //         'into smooth raw render lucky come fury kingdom purchase tent lounge lottery'
    //     )
    //     .slice(0, 32)
    // console.log('')

    res.send({});
})

app.get('/createWallet', (req, res) => {
    console.log('EXECUTE');
    exec('solana-keygen new --no-outfile --no-bip39-passphrase', (error, stdout, stderr) => {
        var split = stdout.split('\n');
        const pubKey = split[2].split(':')[1].trim();
        const mnemonicPhrase = split[5];
        console.log("PUB KEY: ", pubKey);
        console.log('PHRASE: ', mnemonicPhrase);
        // console.log('stdout: ', stdout)
        // console.log('stderr: ', stderr)
        if(error !== null) {
            console.log(`exec error: ${error}`);
        }
    })
    res.send({});
})

app.listen(3000, () => {
    console.log(`Example app listening on port ${3000}`);
    initializeApp({
        credential: cert(serviceAccount)
    })
})
