// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:colorful_iconify_flutter/icons/icon_park.dart' as park_icons;
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:mobile2/constants/colors.dart';
import 'package:mobile2/features/main_navigation/presentation/second_navigation.dart';
import 'package:mobile2/features/occam/presentation/balance.dart';

class MainNavigationScreen extends StatelessWidget {
  MainNavigationScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> _selectedIndex = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
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
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: _selectedIndex,
                  builder: (context, int value, Widget? widget) {
                    return Expanded(
                      child: IndexedStack(
                        index: value,
                        children: const [
                          Center(
                            child: Text('Airdrop Screen'),
                          ),
                          BalanceScreen(),
                          Center(
                            child: Text('Activity Screen'),
                          ),
                          Center(
                            child: Text('Account Screen'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SecondNavigation()
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10),
        child: ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, int value, Widget? widget) {
            return BottomNavigationBar(
              currentIndex: value,
              onTap: (int value) => _selectedIndex.value = value,
              showUnselectedLabels: true,
              unselectedItemColor: AppTheme.primary,
              selectedItemColor: const Color(0xFF00E2FF),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  label: 'Airdrop',
                  icon: Iconify(park_icons.IconPark.parachute),
                ),
                BottomNavigationBarItem(
                  label: 'Occam',
                  icon: Iconify(
                    Fa6Solid.wallet,
                    color: AppTheme.primary,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Activity',
                  icon: Iconify(
                    Ic.baseline_bolt,
                    color: AppTheme.primary,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Account',
                  icon: Iconify(
                    Mdi.account,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
