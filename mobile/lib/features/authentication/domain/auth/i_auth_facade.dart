import 'package:dartz/dartz.dart';

import 'package:mobile/features/authentication/domain/auth/auth_failure.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, Unit>> changeEmailAddress({
    required String newEmail,
    required String newPassword,
  });
}
