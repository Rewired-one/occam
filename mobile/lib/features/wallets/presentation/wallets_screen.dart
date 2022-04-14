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
    final walletsCubit = context.read<WalletsCubit>();
    if (walletsCubit.state.status == WalletsStatus.initial) {
      walletsCubit.fetchWallets();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO:
    // [ ] Last selected wallet should be displayed here
    // [ ] If not wallets, then setup a wallet button

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
        return Drawer(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: double.infinity,
                  child: DrawerHeader(
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                    ),
                    child: Text('Drawer Header'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Wallets',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: context.read<WalletsCubit>().state.wallets.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final wallet = context.read<WalletsCubit>().state.wallets[index];

                      return Container();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}