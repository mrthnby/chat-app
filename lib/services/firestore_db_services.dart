import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/services/base_services/db_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreDbServices implements DBbase {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<bool> saveUser(UserModel user) async {
    Map<String, dynamic> currentUser = user.toMap();
    currentUser.addAll({
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    });

    await db.collection("users").doc(user.userId).set(currentUser);
    return true;
  }

  @override
  Future<UserModel> readUser(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> user =
        await db.collection("users").doc(userId).get();

    Map<String, dynamic> userData = user.data()!;

    if (kDebugMode) {
      print(userData);
    }
    return UserModel.fromMap(userData);
  }

  @override
  Future<bool> updateUser(String newUserName, String userId) async {
    await db.collection("users").doc(userId).update({"userName": newUserName});
    return true;
  }

  @override
  Future<bool> updateProfilePhoto(String userId, String file) async {
    await db.collection("users").doc(userId).update({"profilePic": file});
    return true;
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> allUsers = [];
    QuerySnapshot<Map<String, dynamic>> docs =
        await db.collection("users").get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in docs.docs) {
      UserModel user = UserModel.fromMap(doc.data());
      allUsers.add(user);
    }

    return allUsers;
  }

  @override
  Stream<List<MessageModel>> getMessages(
      String currentUser, String interlocutor) {
    var snapshot = db
        .collection("chat")
        .doc("$currentUser--$interlocutor")
        .collection("messages")
        .orderBy("date")
        .snapshots();

    return snapshot.map((querysnap) => querysnap.docs
        .map((document) => MessageModel.fromMap(document.data())).toList());
  }
}
