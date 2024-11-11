import 'package:flutter/material.dart';
import 'package:traveltoken/model/group_model.dart';
import 'package:traveltoken/repository/firebase_repository.dart';

import '../model/user_model.dart';

class CreateGroupController extends ChangeNotifier {
  final FirebaseRepository signinRepository = FirebaseRepository.instance();

  bool isLoading = false;
  String groupTitle = "";
  List<UserModel> userModelList = [];

  void changeisLoading({required bool value}) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool> createGroup() async {
    changeisLoading(value: true);
    final userData = signinRepository.getUser();
    if (userData != null) {
      final groupModel = GroupModel(
        id: "",
        name: groupTitle,
        createdUserId: userData.uid,
        members: userModelList.map((e) => e.id).toList(),
        date: DateTime.now().millisecondsSinceEpoch,
        isSettled: false,
      );
      changeisLoading(value: false);
      final response =
          await signinRepository.createGroup(groupModel: groupModel);
      // if (response) await getAllGroup();
      return response;
    }

    return false;
  }

  Future<List<UserModel>> searchUsers({required String key}) async {
    return await signinRepository.searchUsers(key: key);
  }

  void addUser({required UserModel user}) {
    if (!userModelList.contains(user)) {
      userModelList.add(user);
      notifyListeners();
    }
  }

  void changeTitle({required String text}) {
    groupTitle = text;
  }

  void removeUser({required UserModel user}) {
    notifyListeners();
    userModelList.remove(user);
  }

  void clearList() {
    userModelList.clear();
    notifyListeners();
  }

  String validateFields() {
    if (groupTitle.isEmpty) {
      return "Group title required";
    }

    if (userModelList.isEmpty) {
      return "Select atleast one user";
    }

    return "";
  }
}
