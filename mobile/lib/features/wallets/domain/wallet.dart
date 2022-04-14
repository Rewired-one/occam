/// A User's wallet which store's SOL and Signs Transactions
abstract class Wallet {
  late String name;
  late String pubKey;
  late String privKey;

  /// A Mneumonic Passphrase 12 - 24 words
  late String mneumonic;

  /// Update the wallets name
  Future<void> updateName(String name);

  /// Destroy the wallet permanently
  Future<void> destroy();

  /// Signs a transactions
  Future<void> sign();

  /// Requests a payment from a user
  Future<void> requestPayment();
}
