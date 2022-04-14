import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/wallets/application/wallets_cubit.dart';

class WalletInfoScreen extends StatefulWidget {
  const WalletInfoScreen({Key? key}) : super(key: key);

  @override
  State<WalletInfoScreen> createState() => _WalletInfoScreenState();
}

class _WalletInfoScreenState extends State<WalletInfoScreen> {
  late final walletsCubit = context.read<WalletsCubit>();

  @override
  void initState() {
    super.initState();
    if (walletsCubit.state.status == WalletsStatus.initial) {
      walletsCubit.fetchWallets();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletsCubit, WalletsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.status == WalletsStatus.loading || state.status == WalletsStatus.initial) {
          return const SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state.status == WalletsStatus.failure) {
          return const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Text('Error Loading Wallets!'),
            ),
          );
        }
        return const SizedBox(
          child: Center(
            child: Text('Wallet Info'),
          ),
        );
      },
    );
  }
}
