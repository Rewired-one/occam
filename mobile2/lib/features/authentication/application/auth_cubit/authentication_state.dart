part of 'authentication_cubit.dart';

enum AuthStatus { initial, loading, error, authenticated, userSignIn, userSignUp }

@immutable
class AuthState {
  const AuthState({
    required this.status,
    this.appUser,
  });

  final AuthStatus status;
  final AppUser? appUser;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState && other.status == status;
  }

  @override
  int get hashCode => status.hashCode;
}
