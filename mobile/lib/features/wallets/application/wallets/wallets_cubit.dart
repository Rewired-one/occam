import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/foundation.dart';
import 'package:mobile/features/wallets/domain/wallet.dart';
import 'package:mobile/features/wallets/infrastructure.dart/wallet_repository.dart';

part 'wallets_state.dart';

class WalletsCubit extends Cubit<WalletsState> {
  WalletsCubit(this.walletRepository) : super(const WalletsState(status: WalletsStatus.initial));
  final WalletRepository walletRepository;

  Future<void> fetchWallets() async {
    emit(const WalletsState(status: WalletsStatus.loading));
    final wallets = await walletRepository.fetchWallets();
    wallets.fold(
      (l) {
        // Find the last selected wallet in Memory
        // If no selected wallet, load index 0
        emit(
          WalletsState(
            status: WalletsStatus.success,
            wallets: l,
            selectedWallet: l[0],
          ),
        );
      },
      (r) => emit(
        const WalletsState(
          status: WalletsStatus.failure,
        ),
      ),
    );
  }

  Future<void> createNewWallet(String displayName) async {
    emit(WalletsState(status: WalletsStatus.loading, wallets: state.wallets));
    final wallet = await walletRepository.createNewWallet(displayName: displayName);
    wallet.fold(
      (l) => emit(
        WalletsState(
          status: WalletsStatus.success,
          selectedWallet: l,
          wallets: [...state.wallets, l],
        ),
      ),
      (r) => const WalletsState(
        status: WalletsStatus.failure,
      ),
    );
  }

  void setupNewWallet() {
    emit(
      const WalletsState(status: WalletsStatus.setup),
    );
  }

  void selectWallet(int index) {
    emit(
      WalletsState(
        status: WalletsStatus.success,
        wallets: state.wallets,
        selectedWallet: state.wallets[index],
      ),
    );
  }
}
