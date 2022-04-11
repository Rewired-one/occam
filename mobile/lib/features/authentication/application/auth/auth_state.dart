part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {
  AuthInitial();
}

class AuthLoading extends AuthState {
  AuthLoading();
}

class AuthSuccess extends AuthState {
  AuthSuccess({
    required this.user,
  });

  final AppUser user;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthSuccess && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() => 'AuthSuccess(user: $user)';
}

class AuthError extends AuthState {
  AuthError(this.message);
  final String message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
