part of 'auth_cubit.dart';

enum AuthStatus { initial, loading, success, failure, signUpSuccess }

class AuthState {
  AuthState({
    required this.status,
    this.user,
    this.authFailure,
  });

  final AuthStatus status;
  final AppUser? user;
  final AuthFailure? authFailure;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState && other.status == status && other.user == user && other.authFailure == authFailure;
  }

  @override
  int get hashCode => status.hashCode ^ user.hashCode ^ authFailure.hashCode;
}
