class User {
  
  User({
    required this.email,
    required this.displayName,
    required this.wallets,
    required this.profilePic,
    required this.addressBook,
  });

  final String email;
  final String displayName;
  final List<String> wallets;
  final String profilePic;
  final List<String> addressBook;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.email == email;
  }

  @override
  int get hashCode => email.hashCode;

  @override
  String toString() => 'User(email: $email)';
}
