part of 'create_wallet_cubit.dart';

enum CreateWalletStatus { initial, loading, error, recoveryPhrase, setPassword }

@immutable
class CreateWalletState {
  const CreateWalletState({
    required this.status,
    this.recoveryCode,
    this.appUser,
  });

  final CreateWalletStatus status;
  final String? recoveryCode;
  final AppUser? appUser;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateWalletState && other.status == status;
  }

  @override
  int get hashCode => status.hashCode;
}