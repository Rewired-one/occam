import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mobile/features/authentication/domain/auth/auth_failure.dart';
import 'package:mobile/features/authentication/domain/auth/i_auth_facade.dart';
import 'package:mobile/features/authentication/domain/user/user.dart';
import 'package:mobile/features/wallets/domain/wallet.dart';

class AuthRepository implements IAuthFacade {
  @override
  Future<Either<AuthFailure, Unit>> changeEmailAddress({required String newEmail, required String newPassword}) {
    // TODO: implement changeEmailAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, AppUser>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final user = await fetchUserFromFirebase(email);
      return right(user);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'invalid-email':
          {
            return left(InvalidEmail('Invalid Email Used!'));
          }
        case 'user-disabled':
          {
            return left(UserDisabled('This User has been disabled!'));
          }

        case 'user-not-found':
          {
            return left(UserNotFound('This user does not exist!'));
          }
        case 'wrong-password':
          {
            return left(InvalidPassword('Invalid password used!'));
          }
      }
      return left(GenericAuthError(error.code));
    }
  }

  @override
  Future<Either<AuthFailure, AppUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      // Create Wallet from Backend
      // Create a settings folder. Add Doc ID to User
      // Upload with User
      final appUser = AppUser(
          appSettingsId: '',
          displayName: displayName,
          appWallet: Wallet(
            mneumonic: '',
            name: 'name',
            privKey: 'privKey',
            pubKey: 'pubKey',
          ),
          email: email,
          id: email);
      return right(appUser);
    } on FirebaseAuthException catch (error) {
      return left(GenericAuthError(error.message!));
    }
  }

  @override
  Future<AppUser> fetchUserFromFirebase(String email) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(email).withConverter<AppUser>(
        fromFirestore: ((snapshot, options) => AppUser.fromSnapshot(snapshot)),
        toFirestore: (user, _) => {
              'addressBookId': user.addressBookId,
              'appSettingsId': user.appSettingsId,
              'displayName': user.displayName,
              'email': user.email,
              'profilePic': user.profilePic,
              'walletId': user.walletId,
            });
    final docSnapshot = await userRef.get();
    final user = docSnapshot.data();
    if (user != null) {
      return user;
    } else {
      throw FirebaseAuthException(code: 'user-not-exist');
    }
  }

  @override
  Future<Either<FailedToCreateUser, AppUser>> createNewUser() {
    // TODO: implement createNewUser
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<AppUser?> fetchUser(String email) async {
    try {
      final data = await FirebaseFirestore.instance.collection('users').doc(email).get();
      if (!data.exists) throw Exception('User does not exists!');
      return AppUser.fromSnapshot(data);
    } catch (error) {
      print('ERROR: $error');
      return null;
    }
  }
}
