part of 'wallets_cubit.dart';

enum WalletsStatus { initial, loading, success, failure }

class WalletsState {
  WalletsState({
    required this.status,
    this.selectedWallet,
    this.wallets = const <Wallet>[],
  });
  final WalletsStatus status;
  final List<Wallet> wallets;
  final Wallet? selectedWallet;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletsState &&
        other.status == status &&
        listEquals(other.wallets, wallets) &&
        other.selectedWallet == selectedWallet;
  }

  @override
  int get hashCode => status.hashCode ^ wallets.hashCode ^ selectedWallet.hashCode;
}
