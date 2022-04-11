abstract class IWalletFailure {
  IWalletFailure({
    required this.message,
  });
  final String message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IWalletFailure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'IWalletFailure(message: $message)';
}

class WalletFailure extends IWalletFailure {
  WalletFailure({required String message}) : super(message: message);
}
