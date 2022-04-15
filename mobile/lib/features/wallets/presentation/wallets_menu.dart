import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/wallets/application/wallets/wallets_cubit.dart';

class WalletsMenu extends StatefulWidget {
  const WalletsMenu({Key? key}) : super(key: key);

  @override
  State<WalletsMenu> createState() => _WalletsMenuState();
}

class _WalletsMenuState extends State<WalletsMenu> {
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
    // [ ] Add Wallet / Connect a new Wallet

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
                    padding: EdgeInsets.zero,
                    itemCount: context.read<WalletsCubit>().state.wallets.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final wallet = context.read<WalletsCubit>().state.wallets[index];
                      final first4 = wallet.pubKey.substring(0, 4);
                      final last4 = wallet.pubKey.substring(wallet.pubKey.length - 4, wallet.pubKey.length);
                      return ListTile(
                        onTap: () {
                          context.read<WalletsCubit>().selectWallet(index);
                          Navigator.pop(context);
                        },
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                wallet.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '($first4...$last4)',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      );
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
