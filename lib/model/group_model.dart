// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class GroupModel {
  final String id;
  final String name;
  final String createdUserId;
  final int date;
  final List<String> members;
  final bool isSettled;
  GroupModel({
    required this.id,
    required this.name,
    required this.createdUserId,
    required this.date,
    required this.members,
    required this.isSettled,
  });

  GroupModel copyWith({
    String? id,
    String? name,
    String? createdUserId,
    int? date,
    List<String>? members,
    bool? isSettled,
  }) {
    return GroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdUserId: createdUserId ?? this.createdUserId,
      date: date ?? this.date,
      members: members ?? this.members,
      isSettled: isSettled ?? this.isSettled,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdUserId': createdUserId,
      'date': date,
      'members': members,
      'isSettled': isSettled,
    };
  }

  factory GroupModel.fromMap(Map<String, dynamic> map) {
    return GroupModel(
        id: map['id'] as String,
        isSettled: map['isSettled'] as bool,
        name: map['name'] as String,
        createdUserId: map['createdUserId'] as String,
        date: map['date'] as int,
        members: List<String>.from(
          (map['members'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory GroupModel.fromJson(String source) =>
      GroupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroupModel(id: $id, name: $name, createdUserId: $createdUserId, date: $date, members: $members, isSettled: $isSettled)';
  }

  @override
  bool operator ==(covariant GroupModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.createdUserId == createdUserId &&
        other.date == date &&
        listEquals(other.members, members) &&
        other.isSettled == isSettled;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        createdUserId.hashCode ^
        date.hashCode ^
        members.hashCode ^
        isSettled.hashCode;
  }
}
