part of 'wallets_cubit.dart';

enum WalletsStatus { initial, loading, success, failure }

class WalletsState {
  WalletsState({
    required this.status,
    this.wallets = const <Wallet>[],
  });
  final WalletsStatus status;
  final List<Wallet> wallets;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletsState && other.status == status && listEquals(other.wallets, wallets);
  }

  @override
  int get hashCode => status.hashCode ^ wallets.hashCode;
}
