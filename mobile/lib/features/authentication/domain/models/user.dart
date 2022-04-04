import 'package:mobile/features/settings/domain/models/settings.dart';

abstract class User {
  late final String id;
  late final String email;
  late final String displayName;
  /// URL Location of Profile Pic in Firebase Storage
  late final String profilePic;
  /// List of Doc IDs for each wallet stored in user's Wallets DB
  late final List<String> wallets;
  /// List of Doc IDs for each address entry in user's Address Book DB
  late final List<String> addressBook;
  late final Settings appSettings;

  /// Update the user's displayName
  Future<void> updateDisplayName(String newName);
  /// Update the user's profile image in Firebase Storage
  Future<void> updateProfilePic();
  /// Delete this user and all corresponding data entries
  Future<void> destroy();
}

/// App User specified Settings


// class User {

//   User({
//     required this.id,
//     required this.email,
//     required this.displayName,
//     this.profilePic,
//     this.wallets = const [],
//     this.addressBook = const [],
//   });

//   final String id;
//   final String email;
//   final String displayName;
//   final List<String> wallets;
//   final String? profilePic;
//   final List<String> addressBook;
  
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
  
//     return other is User &&
//       other.email == email;
//   }

//   @override
//   int get hashCode => email.hashCode;

//   @override
//   String toString() => 'User(email: $email)';
// }
