import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class TokenAsset {
  const TokenAsset({
    required this.name,
    required this.image,
    required this.prefix,
    required this.id,
  });

  final String name;
  final String image;
  final String prefix;
  final String id;

  factory TokenAsset.fromMap(Map<String, dynamic> map) => TokenAsset(
        name: map['name'] as String,
        image: map['image'] as String,
        prefix: map['prefix'] as String,
        id: map['id'] as String,
      );

  String toJson() => jsonEncode(
        <String, dynamic>{
          'name': name,
          'image': image,
          'prefix': prefix,
          'id': id,
        },
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TokenAsset &&
        other.name == name &&
        other.image == image &&
        other.prefix == prefix &&
        other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ image.hashCode ^ prefix.hashCode ^ id.hashCode;
  }
}
