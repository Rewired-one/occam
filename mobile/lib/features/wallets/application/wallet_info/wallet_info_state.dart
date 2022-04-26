part of 'wallet_info_cubit.dart';

enum WalletInfoStatus { initial, loading, failure, success }

@immutable
class WalletInfoState {
  const WalletInfoState({
    required this.status,
    this.balance = '0',
  });

  final String balance;
  final WalletInfoStatus status;
}
