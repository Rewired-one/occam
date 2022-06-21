import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@immutable
class User {
  const User({
    required this.id,
    required this.passcode,
  });

  final String id;
  final Iterable<int> passcode;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() => 'User(id: $id, passcode: $passcode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.passcode == passcode;
  }

  @override
  int get hashCode => id.hashCode ^ passcode.hashCode;
}
