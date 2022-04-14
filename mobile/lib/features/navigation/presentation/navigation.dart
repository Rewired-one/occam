import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile/features/wallets/application/wallets_cubit.dart';
import 'package:mobile/features/wallets/presentation/wallet_info_screen.dart';
import 'package:mobile/features/wallets/presentation/wallets_menu.dart';
import 'package:mobile/features/authentication/presentation/sign_in.dart';
import 'package:mobile/features/authentication/application/auth/auth_cubit.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex = 0;

  // ignore: unused_element
  _changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Occam Wallet'),
        actions: [
          const Center(
            child: Text(
              'Logout',
            ),
          ),
          IconButton(
            onPressed: () async {
              await context.read<AuthCubit>().signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const SignInScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      drawer: const WalletsMenu(),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          WalletInfoScreen(),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Text(
                'Settings Page',
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _changeIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
      ),
    );
  }
}
