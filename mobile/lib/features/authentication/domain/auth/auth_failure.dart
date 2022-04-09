/// Connotates an Authorization Failure from Server response
abstract class AuthFailure {
  AuthFailure(this.message);
  /// Error Message
  late final String message;

  @override
  String toString() => 'AuthFailure(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AuthFailure &&
      other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class InvalidPassword extends AuthFailure {
  InvalidPassword(String message) : super(message);
}

class InvalidEmail extends AuthFailure {
  InvalidEmail(String message) : super(message);
}

class UserNotFound extends AuthFailure {
  UserNotFound(String message) : super(message);
}

class UserDisabled extends AuthFailure {
  UserDisabled(String message) : super(message);
}

class GenericAuthError extends AuthFailure {
  GenericAuthError(String message) : super(message);
}