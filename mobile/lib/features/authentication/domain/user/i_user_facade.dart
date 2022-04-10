import 'package:dartz/dartz.dart';
import 'package:mobile/features/authentication/domain/user/user.dart';

abstract class IUserFacade {
  Future<Either<AppUser, UserFailure>> fetchUserFromFirebase(String email);
  Future<Either<AppUser, UserFailure>> createNewUser();
}

class UserFailure {
  UserFailure({required this.message});
  final String message;
}
