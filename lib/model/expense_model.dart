// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExpenseModel {
  final String id;
  final String groupId;
  final String description;
  final double amount;
  final String date;
  final String paidBy;

  ExpenseModel({
    required this.id,
    required this.groupId,
    required this.description,
    required this.amount,
    required this.date,
    required this.paidBy,
  });

  ExpenseModel copyWith({
    String? id,
    String? groupId,
    String? description,
    double? amount,
    String? date,
    String? paidBy,
  }) {
    return ExpenseModel(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      paidBy: paidBy ?? this.paidBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'groupId': groupId,
      'description': description,
      'amount': amount,
      'date': date,
      'paidBy': paidBy,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as String,
      groupId: map['groupId'] as String,
      description: map['description'] as String,
      amount: map['amount'] as double,
      date: map['date'] as String,
      paidBy: map['paidBy'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExpenseModel(id: $id, groupId: $groupId, description: $description, amount: $amount, date: $date, paidBy: $paidBy)';
  }

  @override
  bool operator ==(covariant ExpenseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.groupId == groupId &&
        other.description == description &&
        other.amount == amount &&
        other.date == date &&
        other.paidBy == paidBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        groupId.hashCode ^
        description.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        paidBy.hashCode;
  }
}
