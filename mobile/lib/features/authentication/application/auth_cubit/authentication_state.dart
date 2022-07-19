part of 'authentication_cubit.dart';

enum AuthStatus { initial, loading, error, authenticated, userSignIn, userSignUp }

@immutable
class AuthState {
  const AuthState({
    required this.status,
    this.appUser,
    this.errorMessage,
    this.cubitLoading,
  });

  final AuthStatus status;
  final AppUser? appUser;
  final String? errorMessage;
  final bool? cubitLoading;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.status == status &&
        other.appUser == appUser &&
        other.errorMessage == errorMessage &&
        other.cubitLoading == cubitLoading;
  }

  @override
  int get hashCode {
    return status.hashCode ^ appUser.hashCode ^ errorMessage.hashCode ^ cubitLoading.hashCode;
  }
}
