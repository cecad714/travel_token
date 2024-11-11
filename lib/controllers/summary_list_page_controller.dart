import 'package:flutter/material.dart';
import 'package:traveltoken/model/group_model.dart';
import 'package:traveltoken/repository/firebase_repository.dart';

class SummaryListPageController extends ChangeNotifier {
  final FirebaseRepository signinRepository = FirebaseRepository.instance();

  bool isLoading = false;
  List<GroupModel> groupModelList = [];

  void changeIsLoadingHome({required bool value}) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> getAllGroup() async {
    changeIsLoadingHome(value: true);
    groupModelList = await signinRepository.getAllGroup(isSettled: true);
    changeIsLoadingHome(value: false);
  }
}
