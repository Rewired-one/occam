part of 'authentication_cubit.dart';

enum AuthStatus { initial, loading, signedIn, needSignUp }

class AuthState {
  AuthState({
    required this.status,
  });

  final AuthStatus status;
}
