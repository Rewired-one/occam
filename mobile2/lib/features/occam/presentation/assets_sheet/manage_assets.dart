import 'package:flutter/material.dart';
import 'package:mobile2/widgets/text_widget.dart';

const assets = [
  {'name': 'Solana', 'prefix': 'SOL', 'image': 'solana.png', 'currentValue': 35.37},
  {'name': 'Bitcoin', 'prefix': 'BTC', 'image': 'bitcoin.png', 'currentValue': 20288.03},
  {'name': 'EOS', 'prefix': 'EOS', 'image': 'eos.png', 'currentValue': 0.946094},
  {'name': 'Ethereum', 'prefix': 'ETH', 'image': 'eth.png', 'currentValue': 1144.51},
  {'name': 'Tether', 'prefix': 'USDT', 'image': 'usdt.png', 'currentValue': 0.999671},
  {'name': 'USD Coin', 'prefix': 'USDC', 'image': 'usdc.png', 'currentValue': 0.999367},
  //----------------------------------
  {'name': 'XRP', 'prefix': 'XRP', 'image': 'usdc.png', 'currentValue': 0.999367},
  {'name': 'Ren', 'prefix': 'REN', 'image': 'usdc.png', 'currentValue': 0.999367},
  {'name': 'Chainlink', 'prefix': 'Link', 'image': 'usdc.png', 'currentValue': 0.999367},
  {'name': 'Binance USD', 'prefix': 'BNB', 'image': 'usdc.png', 'currentValue': 0.999367},
];

class ManageAssetsScreen extends StatelessWidget {
  const ManageAssetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.clear,
            color: Color(0xFFBEBEBE),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: assets.length,
              itemBuilder: (context, index) {
                final asset = assets[index];
                return Row(
                  children: [
                    Image.asset(
                      'assets/images/crypto_assets/${asset['image']}',
                      width: 45,
                      fit: BoxFit.fill,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
