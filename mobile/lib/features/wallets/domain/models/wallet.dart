/// A User's wallet which store's SOL and Signs Transactions
abstract class Wallet {
  late String name;
  late String pubKey;
  /// A Mneumonic Passphrase 12 - 24 words
  late String mneumonic;
  late String privKey;
  /// Current balance of the wallet in SOL token currency
  late double balance;

  /// Update the wallets name
  Future<void> updateName(String name);
  /// Destroy the wallet permanently
  Future<void> destroy();
  /// Signs a transactions
  Future<void> sign();
  /// Requests a payment from a user
  Future<void> requestPayment();
}