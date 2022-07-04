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

    final prefs = await SharedPreferences.getInstance();
    final userAccount = prefs.getString('userAccount');

    // Get previously selected tokens to be views
    final selectedTokens = prefs.getStringList('selectedTokens') ?? [];

    final idsList = selectedTokens.map((e) {
      final decoded = jsonDecode(e);
      return decoded['id'];
    }).toList();

    // Check Balance for each coin

    final uri = Uri.https('api.coingecko.com', '/api/v3/simple/price', {
      'ids': idsList.join(',').toString(),
      'vs_currencies': 'usd',
    });

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final apiResponse = await http.get(uri, headers: headers);

    final decodedApiResponse = jsonDecode(apiResponse.body) as Map<String, dynamic>;

    final List<TokenAsset> tokenAssets = selectedTokens.map((e) {
      final decoded = jsonDecode(e);
      final currentValue = decodedApiResponse[decoded['id']]['usd'];
      return TokenAsset.fromMap(decoded, currentValue);
    }).toList();

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
    final balance = await balanceRepository.checkBalance(state.selectedWallet!.pubKey, network.url);
    emit(
      BalanceState(
        status: BalanceStatus.success,
        walletList: state.walletList,
        selectedWallet: state.selectedWallet,
        balance: balance,
        selectedNetwork: network,
        selectedTokens: state.selectedTokens,
      ),
    );
  }

  Future<void> changeWallet(String walletName) async {
    final newSelectedWallet = state.walletList.singleWhere((wallet) => wallet.walletName == walletName);
    emit(
      BalanceState(
        status: BalanceStatus.loading,
        walletList: state.walletList,
        selectedNetwork: state.selectedNetwork,
        selectedTokens: state.selectedTokens,
      ),
    );
    final balance = await balanceRepository.checkBalance(newSelectedWallet.pubKey, state.selectedNetwork.url);
    emit(
      BalanceState(
        status: BalanceStatus.success,
        walletList: state.walletList,
        selectedNetwork: state.selectedNetwork,
        selectedWallet: newSelectedWallet,
        balance: balance,
        selectedTokens: state.selectedTokens,
      ),
    );
  }

  /// Selects tokens to be viewed on your Balance Sheet
  Future<void> selectToken(String id, bool select) async {
    final prefs = await SharedPreferences.getInstance();
    List<TokenAsset> currentTokenList = [...state.selectedTokens];

    // If select is true, add token to selectedTokens and also shared preference
    if (select) {
      final newToken = tokenAssets.singleWhere((element) => element['id'] == id);
      currentTokenList.add(TokenAsset.fromMap(newToken, 0.0));
    } else {
      // If select == false, remove the selected token from list and shared preferences
      currentTokenList.removeWhere((element) => element.id == id);
    }

    List<String> newSelectedTokenStringList = currentTokenList.map((e) => e.toJson()).toList();
    prefs.setStringList('selectedTokens', newSelectedTokenStringList);

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
