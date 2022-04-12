import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile/features/wallets/domain/wallet.dart';
import 'package:mobile/features/wallets/infrastructure.dart/wallet_repository.dart';

part 'wallets_state.dart';

class WalletsCubit extends Cubit<WalletsState> {
  WalletsCubit(this.walletRepository) : super(WalletsState(status: WalletsStatus.initial));
  final WalletRepository walletRepository;
}
