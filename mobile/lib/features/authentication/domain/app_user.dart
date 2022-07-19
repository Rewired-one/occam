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

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

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
