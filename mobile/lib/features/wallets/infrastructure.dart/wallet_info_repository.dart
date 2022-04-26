import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mobile/features/wallets/domain/i_wallet_info_facade.dart';
import 'package:http/http.dart' as http;

class WalletInfoRepository extends IWalletInfoFacade {
  @override
  Future<Either<String, Unit>> checkBalance(String pubKey) async {
    try {
      Uri uri = Uri.parse('http://localhost:3000/checkBalance');
      final response = await http.post(uri, body: {'pub_key': pubKey});
      if (response.statusCode == 200) {
        final balance = jsonDecode(response.body)['balance'];
        return left(balance);
      } else {
        throw Exception('Error on Check Balance Request!');
      }
    } catch (error) {
      print('ERROR: $error');
      return right(unit);
    }
  }
}
