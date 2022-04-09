import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mobile/features/authentication/domain/auth/auth_failure.dart';
import 'package:mobile/features/authentication/domain/auth/i_auth_facade.dart';

class AuthRepository implements IAuthFacade {
  @override
  Future<Either<AuthFailure, Unit>> changeEmailAddress(
      {required String newEmail, required String newPassword}) {
    // TODO: implement changeEmailAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (error) {
      switch (error.message) {
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
      return left(GenericAuthError(error.message!));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (error) {
      return left(GenericAuthError(error.message!));
    }
  }
}
