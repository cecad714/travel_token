import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:traveltoken/model/user_model.dart';
import 'package:traveltoken/repository/firebase_repository.dart';

class SignInController extends ChangeNotifier {
  final FirebaseRepository signinRepository = FirebaseRepository.instance();
  bool isLoading = false;

  void changeIsLoading({required bool value}) {
    isLoading = value;
    notifyListeners();
  }

  Future<bool> googleSignIn() async {
    changeIsLoading(value: true);
    final credentials = await signinRepository.signInWithGoogle();
    if (credentials != null) {
      final response = signinRepository.createUser(
        userModel: UserModel(
          id: credentials.user?.uid ?? "",
          name: credentials.user?.displayName ?? "",
          profileImageUrl: credentials.user?.photoURL ?? "",
          groupIds: [],
        ),
      );
      changeIsLoading(value: false);
      return response;
    }

    changeIsLoading(value: false);
    return false;
  }

  Future<bool> isUserAuthenticated() async {
    return await signinRepository.isAuthenticated();
  }

  User? getUser() => signinRepository.getUser();
}
