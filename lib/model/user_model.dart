// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  String id;
  String name;
  String profileImageUrl;
  List<String> groupIds;
  UserModel({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.groupIds,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? profileImageUrl,
    List<String>? groupIds,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      groupIds: groupIds ?? this.groupIds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'profileImageUrl': profileImageUrl,
      'groupIds': groupIds,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] as String,
        name: map['name'] as String,
        profileImageUrl: map['profileImageUrl'] as String,
        groupIds: List<String>.from(
          (map['groupIds'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, profileImageUrl: $profileImageUrl, groupIds: $groupIds)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.profileImageUrl == profileImageUrl &&
        listEquals(other.groupIds, groupIds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        profileImageUrl.hashCode ^
        groupIds.hashCode;
  }
}
