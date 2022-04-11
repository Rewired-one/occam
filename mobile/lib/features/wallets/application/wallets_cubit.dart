import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wallets_state.dart';

class WalletsCubit extends Cubit<WalletsState> {
  WalletsCubit() : super(WalletsInitial());
}
