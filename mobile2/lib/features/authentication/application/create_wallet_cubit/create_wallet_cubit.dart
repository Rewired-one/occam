import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile2/features/authentication/infrastructure/create_wallet_repo.dart';

part 'create_wallet_state.dart';

class CreateWalletCubit extends Cubit<CreateWalletState> {
  CreateWalletCubit(this.createWalletRepository) : super(const CreateWalletState(status: CreateWalletStatus.initial));

  final CreateWalletRepository createWalletRepository;

  Future<void> init() async {
    emit(const CreateWalletState(status: CreateWalletStatus.loading));
    // Get Recovery Phrase
    // Create a new User
  }
}
