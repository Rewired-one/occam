part of 'create_wallet_cubit.dart';

enum CreateWalletStatus { initial, loading, error, recoveryPhrase, setPasswordSuccess }

@immutable
class CreateWalletState {
  const CreateWalletState({
    required this.status,
    this.recoveryCode,
    this.appUser,
    this.errorMessage,
  });

  final CreateWalletStatus status;
  final String? recoveryCode;
  final AppUser? appUser;
  final String? errorMessage;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateWalletState &&
        other.status == status &&
        other.recoveryCode == recoveryCode &&
        other.appUser == appUser &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return status.hashCode ^ recoveryCode.hashCode ^ appUser.hashCode ^ errorMessage.hashCode;
  }
}
