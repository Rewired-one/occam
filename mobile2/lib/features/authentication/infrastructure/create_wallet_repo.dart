import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mobile2/features/authentication/domain/i_create_wallet_facade.dart';
import 'package:mobile2/features/authentication/domain/app_user.dart';
import 'package:mobile2/features/authentication/domain/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateWalletRepository implements ICreateWalletFacade {
  @override
  Future<AppUser?> createNewWallet() async {
    try {
      final Uri uri = Uri.parse('http://localhost:3000/createNewUser');
      final response = await http.post(uri);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final user = AppUser.fromJson(responseData['user']);
        return user;
      } else {
        throw Exception('Error with request');
      }
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> registerWalletWithPassword(String email, String password) async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasSignedUp', true);
    prefs.setString('userAccount', user.user!.email!);
  }

  @override
  Future<Wallet> fetchWallet(String id) async {
    final response = await FirebaseFirestore.instance.collection('wallets').doc(id).get();
    final walletData = response.data();
    final wallet = Wallet.fromJson(walletData!['wallets']['master']);
    return wallet;
  }
}
