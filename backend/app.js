var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

const { Keypair } = require('@solana/web3.js');
const { exec } = require('child_process');
const bip39 = require('bip39')
const bs58 = require('bs58')

const { initializeApp, cert } = require("firebase-admin/app");
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

        console.log('PUB KEY: ', pubKey)

        console.log('MNEMONIC: ', mnemonicPhrase)

        const seed = bip39.mnemonicToSeedSync(mnemonicPhrase, "");
        const keypair = Keypair.fromSeed(seed.slice(0, 32));

        console.log('KEYPAIR PUB KEY: ', keypair.publicKey.toBase58());
        const privKey = bs58.encode(keypair.secretKey);
        console.log('KEYPAIR SECRET KEY: ', privKey);

        console.log('PRIV KEY ARRAY: ', keypair.privKey)
        

        if (error !== null) {
            console.log(`exec error: ${error}`);
        }
    })
    res.send({});
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
            return res.send({
                success: false,
                balance: null
            })
        }

        const balance = stdout.split(' ')[0]
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
