import 'package:dartz/dartz.dart';

abstract class IWalletInfoFacade {
  /// Checks the balance on a given public key
  Future<Either<String, Unit>> checkBalance(String pubKey);
}
