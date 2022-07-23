import 'package:dartz/dartz.dart';

import 'package:mobile2/features/authentication/domain/app_user.dart';

abstract class IAuthFacade {
  Future<String?> checkUserHasSignedUp();
  Future<bool> signUp();
  Future<Either<String, AppUser>> signIn(String password);
  Future<void> logout();
}
