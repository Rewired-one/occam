import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:mobile2/features/occam/domain/app_wallet.dart';
import 'package:mobile2/features/occam/infrastructure/balance_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit(this.balanceRepository) : super(const BalanceState(status: BalanceStatus.initial, balance: 0.0));

  final BalanceRepository balanceRepository;

  Future<void> init() async {
    // Get List of Wallets from User
    emit(const BalanceState(status: BalanceStatus.loading));

    final prefs = await SharedPreferences.getInstance();
    final userAccount = prefs.getString('userAccount');

    // Get List of Wallets from User
    final response = await FirebaseFirestore.instance.collection('wallets').doc(userAccount).get();
    final responseData = response.get('wallets') as Map<String, dynamic>;

    final wallets = <AppWallet>[];
    responseData.forEach((key, value) {
      wallets.add(AppWallet.fromJson(value));
    });

    // Select the first Wallet
    final selectedWallet = wallets[0];

    // Check the balance of the Wallet
    final balance = await balanceRepository.checkBalance(selectedWallet.pubKey, state.selectedNetwork.url);

    // Display Results

    emit(
      BalanceState(
        status: BalanceStatus.success,
        selectedWallet: selectedWallet,
        walletList: wallets,
        balance: balance,
      ),
    );
  }

  Future<void> changeNetwork(ClusterNetworks network) async {
    // IF NETWORK IS CHANGED:
    // Check Balance
    // Change Network
  }

  Future<void> changeWallet(String pubKey) async {
    // Check Balance
    // Change Selected Wallet
  }
}
