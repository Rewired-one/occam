import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/wallets/application/wallets/wallets_cubit.dart';
import 'package:mobile/widgets/input.dart';

class SetupWalletScreen extends StatelessWidget {
  SetupWalletScreen({Key? key}) : super(key: key);

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'New Wallet',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Input(
            labelText: 'Display Name',
            controller: _textController,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () => context.read<WalletsCubit>().createNewWallet(_textController.text),
              child: const Text('Create New Wallet'),
            ),
          )
        ],
      ),
    );
  }
}
