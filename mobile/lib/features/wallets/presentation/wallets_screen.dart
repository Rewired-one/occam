import 'dart:developer';

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
  void initState() {
    super.initState();
    context.read<WalletsCubit>().fetchWallets();
  }

  @override
  Widget build(BuildContext context) {
    // TODO:
    // [ ] Last selected wallet should be displayed here
    // [ ] If not wallets, then setup a wallet button

    return BlocConsumer<WalletsCubit, WalletsState>(
      listener: (context, state) {
        print('WALLET STATE FROM LISTENER: ${state.status}');
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

        // Load the most recent selected wallet Balance

        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: state.wallets.length,
                  itemBuilder: (context, index) {
                    final wallet = state.wallets[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Text(wallet.name),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
