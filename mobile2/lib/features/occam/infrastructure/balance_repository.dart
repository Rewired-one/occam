import 'dart:convert';

import 'package:mobile2/features/occam/domain/i_balance_facade.dart';
import 'package:http/http.dart' as http;

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
}
