import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/wallets/infrastructure.dart/wallet_info_repository.dart';

part 'wallet_info_state.dart';

class WalletInfoCubit extends Cubit<WalletInfoState> {
  WalletInfoCubit(this.walletInfoRepository) : super(const WalletInfoState(status: WalletInfoStatus.initial));

  final WalletInfoRepository walletInfoRepository;

  Future<void> fetchBalance(String pubKey) async {
    emit(const WalletInfoState(status: WalletInfoStatus.loading));
    final balance = await walletInfoRepository.checkBalance(pubKey);
    balance.fold(
      (l) => emit(
        WalletInfoState(
          status: WalletInfoStatus.success,
          balance: l,
        ),
      ),
      (r) => emit(
        const WalletInfoState(
          status: WalletInfoStatus.failure,
        ),
      ),
    );
  }

  void reset() {
    emit(
      const WalletInfoState(
        status: WalletInfoStatus.initial,
      ),
    );
  }
}
