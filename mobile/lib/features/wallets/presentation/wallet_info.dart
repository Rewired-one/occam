import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/authentication/application/auth/auth_cubit.dart';
import 'package:mobile/features/authentication/presentation/sign_in.dart';

import 'package:mobile/features/wallets/domain/wallet.dart';
import 'package:mobile/features/wallets/application/wallet_info/wallet_info_cubit.dart';

class WalletInfo extends StatefulWidget {
  const WalletInfo({required this.wallet, Key? key}) : super(key: key);
  final Wallet wallet;

  @override
  State<WalletInfo> createState() => _WalletInfoState();
}

class _WalletInfoState extends State<WalletInfo> {
  @override
  void initState() {
    context.read<WalletInfoCubit>().fetchBalance(widget.wallet.pubKey);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WalletInfo oldWidget) {
    if (widget.wallet.name != oldWidget.wallet.name) {
      context.read<WalletInfoCubit>().reset();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletInfoCubit, WalletInfoState>(
      listener: (context, state) {
        if (state.status == WalletInfoStatus.initial) {
          context.read<WalletInfoCubit>().fetchBalance(widget.wallet.pubKey);
        }
      },
      builder: (context, state) {
        if (state.status == WalletInfoStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == WalletInfoStatus.failure) {
          return const Center(
            child: Text('Failed to Load Balance!'),
          );
        }

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1A2827),
                Color(0xFF0D0D0D),
                Color(0xFF1F1920),
              ],
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const SafeArea(
                child: SizedBox.shrink(),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu),
                    Text('Testnet'),
                    Icon(Icons.qr_code),
                  ],
                ),
              ),
              Text(
                widget.wallet.name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${state.balance} SOL',
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.amber,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
