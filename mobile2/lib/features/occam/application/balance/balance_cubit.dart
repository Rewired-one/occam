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
    emit(
      BalanceState(status: BalanceStatus.loading, walletList: state.walletList, selectedWallet: state.selectedWallet),
    );
    final balance = await balanceRepository.checkBalance(state.selectedWallet!.pubKey, network.url);
    emit(
      BalanceState(
        status: BalanceStatus.success,
        walletList: state.walletList,
        selectedWallet: state.selectedWallet,
        balance: balance,
        selectedNetwork: network,
      ),
    );
  }

  Future<void> changeWallet(String walletName) async {
    final newSelectedWallet = state.walletList.singleWhere((wallet) => wallet.walletName == walletName);
    emit(
      BalanceState(status: BalanceStatus.loading, walletList: state.walletList, selectedNetwork: state.selectedNetwork),
    );
    final balance = await balanceRepository.checkBalance(newSelectedWallet.pubKey, state.selectedNetwork.url);
    emit(
      BalanceState(
        status: BalanceStatus.success,
        walletList: state.walletList,
        selectedNetwork: state.selectedNetwork,
        selectedWallet: newSelectedWallet,
        balance: balance,
      ),
    );
    // Check Balance
    // Change Selected Wallet
  }
}
