part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState { }

class AuthLoading extends AuthState { }

class AuthLoaded extends AuthState {
  
  AuthLoaded({
    required this.user,
  });

  final User user;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthLoaded &&
      other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}
