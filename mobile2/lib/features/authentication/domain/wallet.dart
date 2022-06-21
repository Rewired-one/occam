import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet.g.dart';

@JsonSerializable()
@immutable
class Wallet {
  const Wallet({
    required this.pubKey,
    required this.mnemonicPhrase,
  });

  final String pubKey;
  final String mnemonicPhrase;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WalletToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Wallet && other.pubKey == pubKey && other.mnemonicPhrase == mnemonicPhrase;
  }

  @override
  int get hashCode => pubKey.hashCode ^ mnemonicPhrase.hashCode;
}
