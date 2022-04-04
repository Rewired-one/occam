import 'package:mobile/features/settings/domain/models/settings.dart';

abstract class IUser {
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

class AppUser implements IUser {
  AppUser({
    required this.addressBook,
    required this.appSettings,
    required this.displayName,
    required this.email,
    required this.id,
    required this.profilePic,
    required this.wallets,
  });
  
  @override
  List<String> addressBook;

  @override
  Settings appSettings;

  @override
  String displayName;

  @override
  String email;

  @override
  String id;

  @override
  String profilePic;

  @override
  List<String> wallets;
  

  @override
  Future<void> destroy() {
    // TODO: implement destroy
    throw UnimplementedError();
  }

  @override
  Future<void> updateDisplayName(String newName) {
    // TODO: implement updateDisplayName
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfilePic() {
    // TODO: implement updateProfilePic
    throw UnimplementedError();
  }

}
