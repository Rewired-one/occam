import 'package:flutter/material.dart';
import 'package:mobile2/constants/colors.dart';
import 'package:mobile2/widgets/text_widget.dart';

const assets = [
  {'name': 'Solana', 'prefix': 'SOL', 'image': 'solana.png', 'currentValue': 35.37},
  {'name': 'Bitcoin', 'prefix': 'BTC', 'image': 'bitcoin.png', 'currentValue': 20288.03},
  {'name': 'EOS', 'prefix': 'EOS', 'image': 'eos.png', 'currentValue': 0.946094},
  {'name': 'Ethereum', 'prefix': 'ETH', 'image': 'eth.png', 'currentValue': 1144.51},
  {'name': 'Binance USD', 'prefix': 'BNB', 'image': 'binance.png', 'currentValue': 0.999367},
  {'name': 'Ada', 'prefix': 'ADA', 'image': 'ada.png', 'currentValue': 0.999367},
  {'name': 'Tether', 'prefix': 'USDT', 'image': 'usdt.png', 'currentValue': 0.999671},
  {'name': 'USD Coin', 'prefix': 'USDC', 'image': 'usdc.png', 'currentValue': 0.999367},
  {'name': 'XRP', 'prefix': 'XRP', 'image': 'xrp.png', 'currentValue': 0.999367},
  {'name': 'Ren', 'prefix': 'REN', 'image': 'ren.png', 'currentValue': 0.999367},
  {'name': 'Chainlink', 'prefix': 'Link', 'image': 'chainlink.png', 'currentValue': 0.999367},
  {'name': 'Terra', 'prefix': 'LUNA', 'image': 'luna.png', 'currentValue': 0.999367},
];

class ManageAssetsScreen extends StatelessWidget {
  const ManageAssetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242024),
      appBar: AppBar(
        backgroundColor: const Color(0xFF242024),
        elevation: 0,
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
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/crypto_assets/${asset['image']}',
                                width: 45,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    asset['name'].toString(),
                                  ),
                                  TextWidget(
                                    asset['prefix'].toString(),
                                    color: AppTheme.inactive,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Transform.rotate(
                                angle: .75,
                                child: const Icon(
                                  Icons.push_pin_outlined,
                                  color: Color(0xFFC7C7C7),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              const Icon(
                                Icons.visibility,
                                color: Color(0xFFC7C7C7),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color(0xFF646464),
                    )
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
