// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      pubKey: json['pubKey'] as String,
      mnemonicPhrase: json['mnemonicPhrase'] as String,
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'pubKey': instance.pubKey,
      'mnemonicPhrase': instance.mnemonicPhrase,
    };
