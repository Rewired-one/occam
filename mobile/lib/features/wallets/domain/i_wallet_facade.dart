import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/features/wallets/domain/wallet.dart';

abstract class IWalletFacade {
  get userEmail => FirebaseAuth.instance.currentUser?.email;

  /// Fetch all Wallets the user owns
  Future<Either<List<Wallet>, Unit>> fetchWallets();

  /// Creates a new wallet with a given Display Name
  // TODO: ADD OPTIONS: passphrase
  Future<Either<Wallet, Unit>> createNewWallet({required String displayName});
}
