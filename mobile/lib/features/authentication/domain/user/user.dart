import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile/features/wallets/domain/wallet.dart';

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
  late final String appSettingsId;

  late final List<int> passcode;

  late final Wallet appWallet;

  /// Update the user's displayName
  Future<void> updateDisplayName(String newName);

  /// Update the user's profile image in Firebase Storage
  Future<void> updateProfilePic();

  Future<void> updateWalletId();

  Future<void> updateAddressBookid();

  /// Delete this user and all corresponding data entries
  Future<void> destroy();
}

class AppUser implements IUser {
  AppUser({
    required this.appSettingsId,
    required this.displayName,
    required this.appWallet,
    required this.email,
    required this.id,
    required this.passcode,
    this.addressBookId,
    this.profilePic,
    this.walletId,
  });

  @override
  String? addressBookId;

  @override
  String appSettingsId;

  @override
  String displayName;

  @override
  String email;

  @override
  String id;

  @override
  String? profilePic;

  @override
  String? walletId;

  @override
  Wallet appWallet;

  @override
  List<int> passcode;

  @override
  Future<void> destroy() {
    // TODO: implement destroy
    throw UnimplementedError();
  }

  @override
  Future<void> updateAddressBookid() {
    // TODO: implement updateAddressBookid
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
  Future<void> updateWalletId() {
    // TODO: implement updateWalletId
    throw UnimplementedError();
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'addressBookId': addressBookId});
    result.addAll({'appSettingsId': appSettingsId});
    result.addAll({'displayName': displayName});
    result.addAll({'email': email});
    result.addAll({'id': id});
    result.addAll({'profilePic': profilePic});
    result.addAll({'walletId': email});
    result.addAll({'appWallet': appWallet.toMap()});
    result.addAll({'passcode': passcode});

    return result;
  }

  factory AppUser.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final appWallet = Wallet.fromSnapshot(data['appWallet']);

    return AppUser(
        appWallet: appWallet,
        appSettingsId: data['appSettingsId'],
        displayName: data['displayName'],
        email: data['email'],
        id: doc.id,
        addressBookId: doc['addressBookId'],
        profilePic: doc['profilePic'],
        walletId: doc['walletId'],
        passcode: doc['passcode']);
  }

  Map<String, dynamic> toJson() => {
        'addressBookId': addressBookId,
        'appSettingsId': appSettingsId,
        'displayName': displayName,
        'email': email,
        'profilePic': profilePic,
        'walletId': walletId,
      };

  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, displayName: $displayName, profilePic: $profilePic, walletId: $walletId, addressBookId: $addressBookId, appSettingsId: $appSettingsId)';
  }
}
