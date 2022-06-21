part of 'authentication_cubit.dart';

enum AuthStatus { initial, loading, error, authenticated, userSignIn, userSignUp }

class AuthState {
  AuthState({
    required this.status,
  });

  final AuthStatus status;
}
