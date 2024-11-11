import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:traveltoken/model/expense_model.dart';
import 'package:traveltoken/model/group_model.dart';
import 'package:traveltoken/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  FirebaseRepository._();

  static final FirebaseRepository _instance = FirebaseRepository._();
  factory FirebaseRepository.instance() => _instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //signin
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      return await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      log(e.toString(), name: "Firebase Repository-signInWithGoogle");
    }
    return null;
  }

  Future<bool> createUser({required UserModel userModel}) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Call the user's CollectionReference to add a new user
      final firebaseData = await users.doc(userModel.id).get();
      if (firebaseData.exists) return true;
      return users.doc(userModel.id).set(userModel.toMap()).then((value) {
        log("User Added");
        return true;
      }).catchError((error) {
        log("Failed to add user: $error");
        return false;
      });
    } catch (e) {
      log(e.toString(), name: "Firebase Repository-createUser");
      return false;
    }
  }

  Future<bool> isAuthenticated() async {
    return firebaseAuth.currentUser == null ? false : true;
  }

//group

  Future<bool> createGroup({required GroupModel groupModel}) async {
    try {
      final userData = getUser();
      if (userData == null) {
        return false; // Exit early if no user data
      }

      // Reference to the 'group' collection
      CollectionReference groupReference =
          FirebaseFirestore.instance.collection('group');

      // Create unique group ID using the current timestamp
      final String groupId = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a new list of members including the current user
      final List<String> newList = List.from(groupModel.members);
      newList.add(userData.uid);

      // Add the new group to the 'group' collection
      await groupReference
          .doc(groupId)
          .set(groupModel.copyWith(id: groupId, members: newList).toMap());

      // Update each user's group list
      for (var element in newList) {
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(element)
            .get();
        if (userSnapshot.data() != null) {
          final userModel = UserModel.fromMap(userSnapshot.data()!);
          final userGroupList = List<String>.from(userModel.groupIds);
          userGroupList.add(groupId);

          final updatedUserModel = userModel.copyWith(groupIds: userGroupList);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(element)
              .set(updatedUserModel.toMap());
        }
      }

      log("Group Added");
      return true;
    } catch (error) {
      log("Failed to add group: $error",
          name: "Firebase Repository-createGroup");
      return false;
    }
  }

  Future<List<UserModel>> searchUsers({required String key}) async {
    try {
      if (key.isEmpty) return [];
      final users = await firestore.collection('users').get();

      final userList =
          users.docs.map((e) => UserModel.fromMap(e.data())).toList();

      final filteredUsers = userList
          .where((element) =>
              element.name.toLowerCase().contains(key.toLowerCase()) &&
              element.id != getUser()?.uid)
          .toList();
      return filteredUsers;
    } catch (e) {
      log(e.toString(), name: "Firebase Repository-searchUsers");
      return [];
    }
  }

  //home

  Future<List<GroupModel>> getAllGroup({required bool isSettled}) async {
    try {
      final user = getUser();
      if (user == null) {
        return [];
      }

      // Step 1: Get all group IDs from the user's collection
      final userDoc = await firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        final List<String> groupIds =
            List<String>.from(userDoc.data()?['groupIds'] ?? []);

        // Step 2: Fetch each group using the IDs and collect them into a list
        final List<GroupModel> groupList = [];
        for (var groupId in groupIds) {
          final groupDoc =
              await firestore.collection('group').doc(groupId).get();

          if (groupDoc.exists) {
            // Check if the group's isSettled value matches the filter
            if (groupDoc.data()?['isSettled'] == isSettled) {
              groupList.add(GroupModel.fromMap(groupDoc.data()!));
            }
          }
        }

        return groupList;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString(), name: "Firebase Repository-getAllGroup");
      return [];
    }
  }

  //group p age

  Future<GroupModel?> getGroupDetails(String groupId) async {
    try {
      // Fetch the group document from Firestore using the provided groupId
      final groupDoc = await firestore.collection('group').doc(groupId).get();

      // Check if the document exists and return the GroupModel
      if (groupDoc.exists) {
        return GroupModel.fromMap(groupDoc.data()!);
      } else {
        log("Group not found with ID: $groupId",
            name: "Firebase Repository-getGroupDetails");
        return null;
      }
    } catch (e) {
      log(e.toString(), name: "Firebase Repository-getGroupDetails");
      return null;
    }
  }

  Future<bool> addExpenseToGroup({
    required ExpenseModel expense,
  }) async {
    try {
      // Reference to the group's expenses collection
      CollectionReference expenseReference = firestore
          .collection('group')
          .doc(expense.groupId)
          .collection('expenses');

      final expenseModel = expense.copyWith(
          id: DateTime.now().millisecondsSinceEpoch.toString());

      // Add the new expense to the group's expenses collection
      await expenseReference.doc(expenseModel.id).set(expenseModel.toMap());

      log("Expense Added to Group");
      return true;
    } catch (error) {
      log("Failed to add expense: $error",
          name: "Firebase Repository-addExpenseToGroup");
      return false;
    }
  }

  Future<List<ExpenseModel>> getAllExpensesInGroup(String groupId) async {
    try {
      // Fetch all expense documents from the group's expenses collection
      final expenseQuerySnapshot = await firestore
          .collection('group')
          .doc(groupId)
          .collection('expenses')
          .get();

      // Convert the fetched documents to a list of Expense models
      final expenseList = expenseQuerySnapshot.docs
          .map((doc) => ExpenseModel.fromMap(doc.data()))
          .toList();

      return expenseList;
    } catch (e) {
      log(e.toString(), name: "Firebase Repository-getAllExpensesInGroup");
      return [];
    }
  }

  Future<UserModel?> getUserById(String userId) async {
    try {
      // Fetch the user document from Firestore using the provided userId
      final userDoc = await firestore.collection('users').doc(userId).get();

      // Check if the document exists and return the UserModel
      if (userDoc.exists) {
        return UserModel.fromMap(userDoc.data()!);
      } else {
        log("User not found with ID: $userId",
            name: "Firebase Repository-getUserById");
        return null;
      }
    } catch (e) {
      log(e.toString(), name: "Firebase Repository-getUserById");
      return null;
    }
  }

  Future<bool> settleGroup(String groupId) async {
    try {
      await firestore.collection('group').doc(groupId).update({
        'isSettled': true,
      });
      return true;
    } catch (e) {
      log('Failed to settle group: $e');
      return false;
    }
  }

  Future<void> deleteGroup({required String groupId}) async {
    try {
      // Remove the group document from the 'group' collection
      await firestore.collection('group').doc(groupId).delete();

      // Optionally, update the user records to remove references to this group
      QuerySnapshot<Map<String, dynamic>> userSnapshots =
          await firestore.collection('users').get();
      for (var doc in userSnapshots.docs) {
        List<String> groupIds = List<String>.from(doc.data()['groupIds'] ?? []);
        if (groupIds.contains(groupId)) {
          groupIds.remove(groupId);
          await firestore.collection('users').doc(doc.id).update({
            'groupIds': groupIds,
          });
        }
      }

      log('Group $groupId has been deleted successfully.');
    } catch (e) {
      log('Failed to delete group: $e');
    }
  }

  User? getUser() => firebaseAuth.currentUser;

  //group
}
