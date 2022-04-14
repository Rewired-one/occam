import 'package:dartz/dartz.dart';
import 'package:mobile/features/wallets/domain/wallet.dart';

abstract class IWalletFacade {
  /// Fetch all Wallets the user owns
  Future<Either<List<Wallet>, Unit>> fetchWallets();
}
