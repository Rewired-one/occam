import 'package:mobile2/features/authentication/domain/app_user.dart';
import 'package:mobile2/features/authentication/domain/wallet.dart';

abstract class ICreateWalletFacade {
  Future<AppUser?> createNewWallet();
  Future<Wallet> fetchWallet(String id);
  Future<void> registerWalletWithPassword(String email, String password);
}
