import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/authentication/application/auth/auth_cubit.dart';
import 'package:mobile/features/authentication/presentation/sign_in.dart';
import 'package:mobile/features/navigation/presentation/left_menu.dart';
import 'package:mobile/features/wallets/presentation/wallets_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
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
      drawer: const LeftMenu(),
      body: IndexedStack(
        index: 0,
        children: const [
          WalletsScreen(),
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
        currentIndex: 0,
        onTap: (index) {},
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
