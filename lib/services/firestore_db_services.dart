import 'package:chatapp/models/chat_model.dart';
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
        .orderBy("date", descending: true)
        .snapshots();

    return snapshot.map((querysnap) => querysnap.docs
        .map((document) => MessageModel.fromMap(document.data()))
        .toList());
  }

  @override
  Future<void> saveMessage(MessageModel message) async {
    String docID = db.collection("chat").doc().id;
    String userDocID = "${message.from}--${message.to}";
    String interlocutorDocID = "${message.to}--${message.from}";
    Map<String, dynamic> messageData = message.toMap();
    Map<String, dynamic> counterMessageData = message.toMap();
    counterMessageData.update("isFromMe", (value) => false);
    await db
        .collection("chat")
        .doc(userDocID)
        .collection("messages")
        .doc(docID)
        .set(messageData);

    await db.collection("chat").doc(userDocID).set({
      "owner": message.from,
      "interlocutor": message.to,
      "generateDate": FieldValue.serverTimestamp(),
      "lastMessage": message.content,
      "seen": false,
    });

    await db
        .collection("chat")
        .doc(interlocutorDocID)
        .collection("messages")
        .doc(docID)
        .set(counterMessageData);

    await db.collection("chat").doc(interlocutorDocID).set({
      "owner": message.to,
      "interlocutor": message.from,
      "generateDate": FieldValue.serverTimestamp(),
      "lastMessage": message.content,
      "seen": false,
    });
  }

  @override
  Future<List<ChatModel>> getConversations(String userId) async {
    List<ChatModel> conversations = [];
    QuerySnapshot<Map<String, dynamic>> query = await db
        .collection("chat")
        .where("owner", isEqualTo: userId)
        .orderBy("generateDate", descending: true)
        .get();

    for (DocumentSnapshot<Map<String, dynamic>> snap in query.docs) {
      conversations.add(ChatModel.fromMap(snap.data()!));
    }
    return conversations;
  }
}
