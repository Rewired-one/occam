import 'package:bloc/bloc.dart';
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
    print(user);
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
    // Get Recovery Phrase
    // Create a new User
  }
}
