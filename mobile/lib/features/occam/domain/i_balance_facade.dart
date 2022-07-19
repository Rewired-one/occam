abstract class IBalanceFacade {
  Future<double> checkBalance(String pubKey, String network);
  Future<void> switchNetwork(String network);
  Future<void> switchWallet(String walletId);
}
