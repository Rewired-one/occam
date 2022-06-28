part of 'balance_cubit.dart';

enum BalanceStatus { initial, loading, success }

enum ClusterNetworks {
  mainnet(
    name: 'Mainnet Beta',
    url: 'https://api.mainnet-beta.solana.com',
  ),
  testnet(
    name: 'Testnet',
    url: 'https://api.testnet.solana.com',
  ),
  devnet(
    name: 'Devnet',
    url: 'https://api.devnet.solana.com',
  );

  final String name;
  final String url;

  const ClusterNetworks({
    required this.name,
    required this.url,
  });
}

@immutable
class BalanceState {
  const BalanceState({
    required this.status,
    this.balance = 0.0,
    this.selectedNetwork = ClusterNetworks.devnet,
    this.walletList = const [],
    this.selectedWallet,
  });
  final ClusterNetworks selectedNetwork;
  final BalanceStatus status;
  final double balance;
  final List<AppWallet> walletList;
  final AppWallet? selectedWallet;

  @override
  String toString() => 'BalanceState(selectedNetwork: $selectedNetwork, status: $status, balance: $balance)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BalanceState &&
        other.selectedNetwork == selectedNetwork &&
        other.status == status &&
        other.balance == balance &&
        listEquals(other.walletList, walletList) &&
        other.selectedWallet == selectedWallet;
  }

  @override
  int get hashCode {
    return selectedNetwork.hashCode ^
        status.hashCode ^
        balance.hashCode ^
        walletList.hashCode ^
        selectedWallet.hashCode;
  }
}
