import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile2/features/occam/domain/app_wallet.dart';
import 'package:mobile2/features/occam/domain/token_asset.dart';
import 'package:mobile2/features/occam/domain/i_balance_facade.dart';

class BalanceRepository implements IBalanceFacade {
  // TODO: Add Error Check
  @override
  Future<double> checkBalance(String pubKey, String network) async {
    try {
      final Uri uri = Uri.parse('http://localhost:3000/checkBalance');

      Map<String, String> headers = <String, String>{
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({'network': network, 'pubKey': pubKey});

      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return double.parse(responseData['balance']);
      } else {
        throw Exception('Error with request');
      }
    } on Exception catch (error) {
      print('ERROR: ${error.toString()}');
      return 0.0;
    }
  }

  @override
  Future<void> switchNetwork(String network) {
    // TODO: implement switchNetwork
    throw UnimplementedError();
  }

  @override
  Future<void> switchWallet(String walletId) {
    // TODO: implement switchWallet
    throw UnimplementedError();
  }

  Future<Map<String, double>> checkTokenPrices(List<String> ids) async {
    final uri = Uri.https('api.coingecko.com', '/api/v3/simple/price', {
      'ids': ids.join(',').toString(),
      'vs_currencies': 'usd',
    });

    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final apiResponse = await http.get(uri, headers: headers);
    final decodedApiResponse = jsonDecode(apiResponse.body) as Map<String, dynamic>;
    final tokenPrices = <String, double>{
      for (final key in decodedApiResponse.keys) key: decodedApiResponse[key]['usd'].toDouble()
    };
    return tokenPrices;
  }

  Future<List<AppWallet>> fetchUserWallets() async {
    final prefs = await SharedPreferences.getInstance();
    final userAccount = prefs.getString('userAccount');

    final response = await FirebaseFirestore.instance.collection('wallets').doc(userAccount).get();
    final responseData = response.get('wallets') as Map<String, dynamic>;

    final wallets = <AppWallet>[];
    responseData.forEach((key, value) {
      wallets.add(AppWallet.fromJson(value));
    });

    return wallets;
  }

  Future<List<TokenAsset>> fetchTokenAssets() async {
    final prefs = await SharedPreferences.getInstance();

    // Get previously selected tokens to be views
    final selectedTokens = prefs.getStringList('selectedTokens') ?? [];

    final idsList = selectedTokens.map((e) {
      final decoded = jsonDecode(e);
      return decoded['id'] as String;
    }).toList();

    final tokenPrices = await checkTokenPrices(idsList);

    final List<TokenAsset> tokenAssets = selectedTokens.map((e) {
      final decoded = jsonDecode(e);
      final currentValue = tokenPrices[decoded['id']];
      return TokenAsset.fromMap(decoded, currentValue!);
    }).toList();

    return tokenAssets;
  }
}
