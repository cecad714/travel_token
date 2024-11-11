import 'package:flutter/material.dart';
import 'package:traveltoken/model/expense_model.dart';
import 'package:traveltoken/model/user_model.dart';
import 'package:traveltoken/repository/firebase_repository.dart';

class SummaryController extends ChangeNotifier {
  final FirebaseRepository signinRepository = FirebaseRepository.instance();

  Future<Map<String, String>> fetchUsernames(List<String> userIds) async {
    Map<String, String> userIdToUsername = {};

    for (var userId in userIds) {
      final UserModel? user = await signinRepository.getUserById(userId);
      if (user != null) {
        userIdToUsername[userId] =
            user.name; // Directly accessing the name from UserModel
      }
    }

    return userIdToUsername;
  }

  Future<Map<String, double>> calculateTotalExpenses(
      List<ExpenseModel> expenses) async {
    Map<String, double> totals = {};

    // Get the list of all unique user IDs
    List<String> userIds =
        expenses.map((expense) => expense.paidBy).toSet().toList();

    // Fetch usernames based on user IDs
    Map<String, String> userIdToUsername = await fetchUsernames(userIds);

    for (var expense in expenses) {
      String username = userIdToUsername[expense.paidBy] ?? 'Unknown';

      if (totals.containsKey(username)) {
        totals[username] = totals[username]! + expense.amount;
      } else {
        totals[username] = expense.amount;
      }
    }

    return totals;
  }

  List<String> calculateDebts(
      Map<String, double> totals, double averageExpense) {
    List<String> debts = [];

    totals.forEach((username, total) {
      double balance = total - averageExpense;
      if (balance < 0) {
        debts.add("$username owes ₹ ${balance.abs()}");
      } else if (balance > 0) {
        debts.add("$username receives ₹ $balance");
      } else {
        debts.add("$username is settled");
      }
    });

    return debts;
  }

  Future<List<String>> generateSummary(String groupId) async {
    List<ExpenseModel> expenses =
        await signinRepository.getAllExpensesInGroup(groupId);

    // Calculate total expenses per member
    Map<String, double> totals = await calculateTotalExpenses(expenses);

    // Calculate the average expense per member
    double totalGroupExpense =
        expenses.fold(0, (sum, expense) => sum + expense.amount);
    int numMembers = totals.length;
    double averageExpense = totalGroupExpense / numMembers;

    // Generate debt summary
    List<String> debts = calculateDebts(totals, averageExpense);

    return debts;
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
