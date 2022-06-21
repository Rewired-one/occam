abstract class ICreateWalletFacade {
  Future<void> createNewWallet();
  Future<void> registerWalletWithPassword();
}
