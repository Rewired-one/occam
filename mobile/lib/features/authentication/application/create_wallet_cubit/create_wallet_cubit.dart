import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import 'package:mobile2/features/authentication/domain/app_user.dart';
import 'package:mobile2/features/authentication/infrastructure/create_wallet_repo.dart';

part 'create_wallet_state.dart';

class CreateWalletCubit extends Cubit<CreateWalletState> {
  CreateWalletCubit(this.createWalletRepository) : super(const CreateWalletState(status: CreateWalletStatus.initial));

  final CreateWalletRepository createWalletRepository;

  Future<void> init() async {
    emit(const CreateWalletState(status: CreateWalletStatus.loading));
    final user = await createWalletRepository.createNewWallet();
    if (user != null) {
      final wallet = await createWalletRepository.fetchWallet(user.id);
      emit(
        CreateWalletState(
          status: CreateWalletStatus.recoveryPhrase,
          recoveryCode: wallet.mnemonicPhrase,
          appUser: user,
        ),
      );
    } else {
      emit(const CreateWalletState(status: CreateWalletStatus.error));
    }
  }

  Future<void> registerWalletWithPassword(String password) async {
    emit(CreateWalletState(status: CreateWalletStatus.loading, appUser: state.appUser));
    final response = await createWalletRepository.registerWalletWithPassword(state.appUser!.id, password);
    response.fold(
      (l) => emit(
        CreateWalletState(
          status: CreateWalletStatus.error,
          appUser: state.appUser,
          recoveryCode: state.recoveryCode,
          errorMessage: l,
        ),
      ),
      (r) => emit(
        const CreateWalletState(status: CreateWalletStatus.setPasswordSuccess),
      ),
    );
  }
}
