import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:mobile2/constants/token_assets.dart';
import 'package:mobile2/features/occam/domain/app_wallet.dart';
import 'package:mobile2/features/occam/domain/token_asset.dart';
import 'package:mobile2/features/occam/infrastructure/balance_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

part 'balance_state.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit(this.balanceRepository) : super(const BalanceState(status: BalanceStatus.initial, balance: 0.0));

  final BalanceRepository balanceRepository;

  Future<void> init() async {
    // Get List of Wallets from User
    emit(const BalanceState(status: BalanceStatus.loading));

    // Get List of Wallets from User
    final wallets = await balanceRepository.fetchUserWallets();

    // Select the first Wallet
    final selectedWallet = wallets[0];

    // Check the SOL balance of the Wallet
    final balance = await balanceRepository.checkBalance(selectedWallet.pubKey, state.selectedNetwork.url);

    // fetch tokenAssets
    final tokenAssets = await balanceRepository.fetchTokenAssets();

    final solCurrentValue = tokenAssets.singleWhere((element) => element.id == 'solana').currentValue;

    final solanaBalanceInUSD = balance * solCurrentValue;

    emit(
      BalanceState(
        status: BalanceStatus.success,
        selectedWallet: selectedWallet,
        walletList: wallets,
        balance: solanaBalanceInUSD,
        selectedTokens: tokenAssets,
      ),
    );
  }

  Future<void> changeNetwork(ClusterNetworks network) async {
    emit(
      BalanceState(
        status: BalanceStatus.loading,
        walletList: state.walletList,
        selectedWallet: state.selectedWallet,
        selectedTokens: state.selectedTokens,
      ),
    );
    // fetch tokenAssets
    final balance = await balanceRepository.checkBalance(state.selectedWallet!.pubKey, network.url);
    final tokenAssets = await balanceRepository.fetchTokenAssets();
    final solCurrentValue = tokenAssets.singleWhere((element) => element.id == 'solana').currentValue;
    final solanaBalanceInUSD = balance * solCurrentValue;

    emit(
      BalanceState(
        status: BalanceStatus.success,
        walletList: state.walletList,
        selectedWallet: state.selectedWallet,
        balance: solanaBalanceInUSD,
        selectedNetwork: network,
        selectedTokens: tokenAssets,
      ),
    );
  }

  Future<void> changeWallet(String walletName) async {
    emit(
      BalanceState(
        status: BalanceStatus.loading,
        walletList: state.walletList,
        selectedNetwork: state.selectedNetwork,
        selectedTokens: state.selectedTokens,
      ),
    );
    final newSelectedWallet = state.walletList.singleWhere((wallet) => wallet.walletName == walletName);
    // fetch tokenAssets
    final balance = await balanceRepository.checkBalance(newSelectedWallet.pubKey, state.selectedNetwork.url);
    final tokenAssets = await balanceRepository.fetchTokenAssets();
    final solCurrentValue = tokenAssets.singleWhere((element) => element.id == 'solana').currentValue;
    final solanaBalanceInUSD = balance * solCurrentValue;
    emit(
      BalanceState(
        status: BalanceStatus.success,
        walletList: state.walletList,
        selectedNetwork: state.selectedNetwork,
        selectedWallet: newSelectedWallet,
        balance: solanaBalanceInUSD,
        selectedTokens: tokenAssets,
      ),
    );
  }

  /// Selects tokens to be viewed on your Balance Sheet
  Future<void> selectToken(String id, bool select) async {
    List<TokenAsset> currentTokenList = [...state.selectedTokens];

    // If select is true, add token to selectedTokens and also shared preference
    if (select) {
      // Check Balance for each coin
      final currentTokenBalances = await balanceRepository.checkTokenPrices([id]);

      final newToken = tokenAssets.singleWhere((element) => element['id'] == id);
      currentTokenList.add(TokenAsset.fromMap(newToken, currentTokenBalances[id]!));
    } else {
      // If select == false, remove the selected token from list and shared preferences
      currentTokenList.removeWhere((element) => element.id == id);
    }

    // Save newly selected token to shared preferences

    List<String> newSelectedTokenStringList = currentTokenList.map((e) => e.toJson()).toList();
    // ignore: avoid_single_cascade_in_expression_statements
    await SharedPreferences.getInstance()
      ..setStringList('selectedTokens', newSelectedTokenStringList);

    emit(
      BalanceState(
        status: BalanceStatus.success,
        walletList: state.walletList,
        selectedNetwork: state.selectedNetwork,
        selectedWallet: state.selectedWallet,
        balance: state.balance,
        selectedTokens: currentTokenList,
      ),
    );
  }
}
