var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

const { Keypair } = require('@solana/web3.js');
const { exec } = require('child_process');

const { initializeApp, cert } = require("firebase-admin/app");
const { getFirestore } = require('firebase-admin/firestore');
var serviceAccount = require("./service_account.json");

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.get('/createWallet', (req, res) => {
    const { userId } = req.body
    exec('sh ./scripts/wallet.sh', (error, stdout, stderr) => {
        const split = stdout.split('\n');
        const pubKey = split[2].split(':')[1].trim();
        const mnemonicPhrase = split[5];
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
