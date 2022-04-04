import 'package:dartz/dartz.dart';

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
      {required String email, required String password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signUpWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }
}
