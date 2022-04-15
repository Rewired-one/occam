import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wallet_info_state.dart';

class WalletInfoCubit extends Cubit<WalletInfoState> {
  WalletInfoCubit() : super(const WalletInfoState(status: WalletInfoStatus.initial));

  Future<void> fetchBalance(String pubKey) async {}
}
