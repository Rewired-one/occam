part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {
  AuthInitial();
}

class AuthLoading extends AuthState {
  AuthLoading();
}

class AuthLoaded extends AuthState {
  AuthLoaded();
}

class AuthError extends AuthState {
  AuthError(this.authFailure);
  final AuthFailure authFailure;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthError && other.authFailure == authFailure;
  }

  @override
  int get hashCode => authFailure.hashCode;
}
