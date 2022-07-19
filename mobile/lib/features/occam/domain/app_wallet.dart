import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_wallet.g.dart';

@JsonSerializable()
@immutable
class AppWallet {
  const AppWallet({
    required this.walletName,
    required this.isMaster,
    required this.mnemonicPhrase,
    required this.privKey,
    required this.pubKey,
  });

  final String walletName;
  final bool isMaster;
  final String mnemonicPhrase;
  final String privKey;
  final String pubKey;

  factory AppWallet.fromJson(Map<String, dynamic> json) => _$AppWalletFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AppWalletToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppWallet &&
        other.walletName == walletName &&
        other.isMaster == isMaster &&
        other.mnemonicPhrase == mnemonicPhrase &&
        other.privKey == privKey &&
        other.pubKey == pubKey;
  }

  @override
  int get hashCode {
    return walletName.hashCode ^ isMaster.hashCode ^ mnemonicPhrase.hashCode ^ privKey.hashCode ^ pubKey.hashCode;
  }

  @override
  String toString() {
    return 'AppWallet(walletName: $walletName, isMaster: $isMaster, mnemonicPhrase: $mnemonicPhrase, privKey: $privKey, pubKey: $pubKey)';
  }
}
