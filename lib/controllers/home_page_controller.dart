import 'package:flutter/material.dart';
import 'package:traveltoken/model/group_model.dart';
import 'package:traveltoken/repository/firebase_repository.dart';

class HomePageController extends ChangeNotifier {
  final FirebaseRepository signinRepository = FirebaseRepository.instance();

  bool isLoadingHome = false;
  List<GroupModel> groupModelList = [];

  void changeIsLoadingHome({required bool value}) {
    isLoadingHome = value;
    notifyListeners();
  }

  Future<void> getAllGroup() async {
    changeIsLoadingHome(value: true);
    groupModelList = await signinRepository.getAllGroup(isSettled: false);
    changeIsLoadingHome(value: false);
  }

  Future<void> deleteGroup({required String groupId}) async {
    changeIsLoadingHome(value: true);
    await signinRepository.deleteGroup(groupId: groupId);

    changeIsLoadingHome(value: false);
  }

  Future<double> calculateTotalExpense({required String groupId}) async {
    final expenseList = await signinRepository.getAllExpensesInGroup(groupId);
    double totalExpense = 0;
    for (var expense in expenseList) {
      totalExpense += expense.amount;
    }
    return totalExpense;
  }
}
