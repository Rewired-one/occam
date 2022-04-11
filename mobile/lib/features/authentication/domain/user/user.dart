import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  /// Update the user's displayName
  Future<void> updateDisplayName(String newName);

  /// Update the user's profile image in Firebase Storage
  Future<void> updateProfilePic();

  Future<void> updateWalletId();

  Future<void> updateAddressBookid();

  /// Delete this user and all corresponding data entries
  Future<void> destroy();

  @override
  String toString() {
    return 'IUser(id: $id, email: $email, displayName: $displayName, profilePic: $profilePic, walletId: $walletId, addressBookId: $addressBookId, appSettingsId: $appSettingsId)';
  }
}

class AppUser implements IUser {
  AppUser({
    this.addressBookId,
    required this.appSettingsId,
    required this.displayName,
    required this.email,
    required this.id,
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
    if (profilePic != null) {
      result.addAll({'profilePic': profilePic});
    }
    if (walletId != null) {
      result.addAll({'walletId': walletId});
    }

    return result;
  }

  factory AppUser.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser(
        appSettingsId: data['appSettingsId'],
        displayName: data['displayName'],
        email: data['email'],
        id: doc.id,
        addressBookId: doc['addressBookId'],
        profilePic: doc['profilePic'],
        walletId: doc['walletId']);
  }

  Map<String, dynamic> toJson() => {
        'addressBookId': addressBookId,
        'appSettingsId': appSettingsId,
        'displayName': displayName,
        'email': email,
        'profilePic': profilePic,
        'walletId': walletId,
      };

  AppUser.fromJson(Map<String, dynamic> json)
      : this(
          addressBookId: json['addressBookId'],
          appSettingsId: json['appSettingsId'],
          displayName: json['displayName'],
          email: json['email'],
          id: json['email'],
          profilePic: json['profilePic'],
          walletId: json['walletId'],
        );
}
