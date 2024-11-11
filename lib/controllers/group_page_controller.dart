import 'package:flutter/material.dart';
import 'package:traveltoken/model/expense_model.dart';
import 'package:traveltoken/model/user_model.dart';
import 'package:traveltoken/repository/firebase_repository.dart';

class GroupPageController extends ChangeNotifier {
  final FirebaseRepository signinRepository = FirebaseRepository.instance();
  bool isLoading = false;

  List<ExpenseModel> expenseModelList = [];

  void changeIsLoading({required bool value}) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getAllExpenses({required String groupId}) async {
    changeIsLoading(value: true);
    expenseModelList = await signinRepository.getAllExpensesInGroup(groupId);
    changeIsLoading(value: false);
  }

  Future<UserModel?> getuserFromId({required String userId}) async {
    return await signinRepository.getUserById(userId);
  }

  Future<bool> settleGroup({required String groudId}) async {
    return await signinRepository.settleGroup(groudId);
  }
}
