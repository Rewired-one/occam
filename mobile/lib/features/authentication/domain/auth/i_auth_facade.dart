import 'package:dartz/dartz.dart';

import 'package:mobile/features/authentication/domain/auth/auth_failure.dart';
import 'package:mobile/features/authentication/domain/user/user.dart';

abstract class IAuthFacade {
  Future<AppUser> fetchUserFromFirebase(String email);
  Future<Either<FailedToCreateUser, AppUser>> createNewUser();
  Future<Either<AuthFailure, Unit>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, AppUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Either<AuthFailure, Unit>> changeEmailAddress({
    required String newEmail,
    required String newPassword,
  });
}
