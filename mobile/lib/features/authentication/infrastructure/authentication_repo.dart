import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mobile2/features/authentication/domain/app_user.dart';
import 'package:mobile2/features/authentication/domain/i_auth_facade.dart';

class AuthenticationRepository implements IAuthFacade {
  @override
  Future<String?> checkUserHasSignedUp() async {
    final prefs = await SharedPreferences.getInstance();

    final bool? hasSignedUp = prefs.getBool('hasSignedUp');
    if (hasSignedUp ?? false) {
      final String? userAccount = prefs.getString('userAccount');
      return userAccount;
    } else {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (error) {
      print('ERROR ON LOGOUT: ${error.message}');
    }
  }

  @override
  Future<Either<String, AppUser>> signIn(String password) async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userAccount');
    try {
      if (email != null) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.toLowerCase(), password: password);
        final response = await FirebaseFirestore.instance.collection('users').doc(email).get();
        if (response.data() == null) throw Exception('No User Found!');
        final appUser = AppUser.fromJson(response.data()!);
        return right(appUser);
      } else {
        throw Exception('No Email Stored on Shared Preferences!');
      }
    } on FirebaseAuthException catch (error) {
      return left(error.message!);
    } on Exception catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<bool> signUp() async {
    return true;
  }
}
