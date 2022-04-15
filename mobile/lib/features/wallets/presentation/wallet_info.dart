import 'package:flutter/material.dart';
import 'package:mobile/features/wallets/domain/wallet.dart';

class WalletInfo extends StatefulWidget {
  const WalletInfo({required this.wallet, Key? key}) : super(key: key);
  final Wallet wallet;

  @override
  State<WalletInfo> createState() => _WalletInfoState();
}

class _WalletInfoState extends State<WalletInfo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            widget.wallet.name,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '\$0.00',
            style: TextStyle(
              fontSize: 40,
              color: Colors.amber,
            ),
          )
        ],
      ),
    );
  }
}
