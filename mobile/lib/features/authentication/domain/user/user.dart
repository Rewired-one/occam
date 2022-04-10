abstract class IUser {
  late final String id;
  late final String email;
  late final String displayName;

  /// URL Location of Profile Pic in Firebase Storage.
  ///
  /// If `null`, the user has not set a profile pic yet, or has been deleted.
  late final String? profilePic;

  /// Doc ID pointing to the User's Wallets
  late final String? walletId;

  /// Doc ID pointing to the User's Address Book
  late final String? addressBookId;

  /// Doc ID pointing to the User's provided settings.
  // TODO: Create App Settings doc when creating user
  late final String appSettings;

  /// Update the user's displayName
  Future<void> updateDisplayName(String newName);

  /// Update the user's profile image in Firebase Storage
  Future<void> updateProfilePic();

  Future<void> updateWalletId();

  Future<void> updateAddressBookid();

  /// Delete this user and all corresponding data entries
  Future<void> destroy();
}

class AppUser extends IUser {
  AppUser({
    required String id,
    required String email,
    required String displayName,
    required String appSettings,
    String? profilePic,
    List<String> wallets = const [],
    List<String> addressBook = const [],
  });

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

  @override
  Future<void> updateAddressBookid() {
    // TODO: implement updateAddressBookid
    throw UnimplementedError();
  }

  @override
  Future<void> updateWalletId() {
    // TODO: implement updateWalletId
    throw UnimplementedError();
  }
}
