import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
@immutable
class AppUser {
  const AppUser({
    required this.id,
    required this.passcode,
  });

  final String id;
  final Iterable<int> passcode;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  @override
  String toString() => 'AppUser(id: $id, passcode: $passcode)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser && other.id == id && other.passcode == passcode;
  }

  @override
  int get hashCode => id.hashCode ^ passcode.hashCode;
}
