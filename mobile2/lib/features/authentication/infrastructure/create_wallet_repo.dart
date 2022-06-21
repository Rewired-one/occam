import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile2/features/authentication/domain/i_create_wallet_facade.dart';
import 'package:mobile2/features/authentication/domain/user.dart';

class CreateWalletRepository implements ICreateWalletFacade {
  @override
  Future<User?> createNewWallet() async {
    try {
      final Uri uri = Uri.parse('http://localhost:3000/createNewUser');
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final user = User.fromJson(responseData['user']);
        return user;
      } else {
        throw Exception('Error with request');
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> registerWalletWithPassword() {
    // TODO: implement registerWalletWithPassword
    throw UnimplementedError();
  }
}
