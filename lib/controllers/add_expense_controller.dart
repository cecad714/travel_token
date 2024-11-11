import 'package:flutter/material.dart';
import 'package:traveltoken/model/expense_model.dart';
import 'package:traveltoken/repository/firebase_repository.dart';

class AddExpenseController extends ChangeNotifier {
  final FirebaseRepository signinRepository = FirebaseRepository.instance();

  //add expense
  String description = "";
  double amount = 0;

  bool isLoading = false;

  void changeIsLoading({required bool value}) {
    isLoading = value;
    notifyListeners();
  }

  void changeDescription({required String value}) {
    description = value;
  }

  void changeAmount({required String value}) {
    amount = double.tryParse(value) ?? 0;
  }

  String validateFields() {
    if (description.isEmpty) {
      return "Descroption required";
    }
    if (amount < 0) {
      return "Invalid amount";
    }

    return "";
  }

  Future<bool> createExpense({required String groupId}) async {
    final ExpenseModel expenseModel = ExpenseModel(
      id: "",
      groupId: groupId,
      description: description,
      amount: amount,
      date: DateTime.now().millisecondsSinceEpoch.toString(),
      paidBy: signinRepository.getUser()?.uid ?? "",
    );
    return await signinRepository.addExpenseToGroup(expense: expenseModel);
  }
}
