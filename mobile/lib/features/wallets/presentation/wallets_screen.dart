import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/wallets/application/wallets_cubit.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  State<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletsCubit, WalletsState>(
      listener: (context, state) {
        if (state.status == WalletsStatus.initial) {
          // Get Wallets
          context.read<WalletsCubit>().fetchWallets();
        }
      },
      builder: (context, state) {
        return Container();
      },
    );
  }
}
