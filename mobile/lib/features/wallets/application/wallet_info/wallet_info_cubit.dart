import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wallet_info_state.dart';

class WalletInfoCubit extends Cubit<WalletInfoState> {
  WalletInfoCubit() : super(const WalletInfoState(status: WalletInfoStatus.initial));

  Future<void> fetchBalance(String pubKey) async {
    print('FETCH BALANCE');
    emit(const WalletInfoState(status: WalletInfoStatus.loading));
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      print('done');
      emit(const WalletInfoState(status: WalletInfoStatus.success, balance: 1.01));
    });
  }

  void reset() {
    emit(
      const WalletInfoState(
        status: WalletInfoStatus.initial,
      ),
    );
  }
}
