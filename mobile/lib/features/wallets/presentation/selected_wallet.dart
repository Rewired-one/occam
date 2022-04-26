import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/wallets/application/wallets/wallets_cubit.dart';
import 'package:mobile/features/wallets/presentation/setup_wallet.dart';
import 'package:mobile/features/wallets/presentation/wallet_info.dart';

class SelectedWallet extends StatefulWidget {
  const SelectedWallet({Key? key}) : super(key: key);

  @override
  State<SelectedWallet> createState() => _SelectedWalletState();
}

class _SelectedWalletState extends State<SelectedWallet> {
  late final walletsCubit = context.read<WalletsCubit>();

  @override
  void initState() {
    super.initState();
    if (walletsCubit.state.status == WalletsStatus.initial) {
      walletsCubit.fetchWallets();
    }
  }

  // TODO:
  // [ ] Display Balance
  // [ ] Display Selected Network
  // [ ] Display User buttons
  //     [ ] Airdrop SOL
  //     [ ] Send SOL
  //     [ ] Recieve SOL (Request a Payment)

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
        if (state.status == WalletsStatus.setup) {
          return SetupWalletScreen();
        }
        if (state.wallets.isNotEmpty && state.status == WalletsStatus.success) {
          return WalletInfo(wallet: state.selectedWallet!);
        } else {
          return const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Text('Setup your First Wallet!'),
            ),
          );
        }
      },
    );
  }
}
