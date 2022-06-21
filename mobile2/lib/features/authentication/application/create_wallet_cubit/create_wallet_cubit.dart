import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_wallet_state.dart';

class CreateWalletCubit extends Cubit<CreateWalletState> {
  CreateWalletCubit() : super(CreateWalletInitial());
}
