// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppWallet _$AppWalletFromJson(Map<String, dynamic> json) => AppWallet(
      walletName: json['walletName'] as String,
      isMaster: json['isMaster'] as bool,
      mnemonicPhrase: json['mnemonicPhrase'] as String,
      privKey: json['privKey'] as String,
      pubKey: json['pubKey'] as String,
    );

Map<String, dynamic> _$AppWalletToJson(AppWallet instance) => <String, dynamic>{
      'walletName': instance.walletName,
      'isMaster': instance.isMaster,
      'mnemonicPhrase': instance.mnemonicPhrase,
      'privKey': instance.privKey,
      'pubKey': instance.pubKey,
    };
