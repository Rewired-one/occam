var express = require('express')
var path = require('path')
var cookieParser = require('cookie-parser')
var logger = require('morgan')
const { Keypair } = require('@solana/web3.js')

var app = express()

app.use(logger('dev'))
app.use(express.json())
app.use(express.urlencoded({ extended: false }))
app.use(cookieParser())
app.use(express.static(path.join(__dirname, 'public')))

app.get('/', (req, res) => {
    const seed = bip39
        .mnemonicToSeedSync(
            'into smooth raw render lucky come fury kingdom purchase tent lounge lottery'
        )
        .slice(0, 32)
    console.log('')

    res.send({})
})

app.listen(3000, () => {
    console.log(`Example app listening on port ${3000}`)
})
