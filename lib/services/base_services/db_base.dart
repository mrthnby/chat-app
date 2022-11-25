import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/models/user_model.dart';

abstract class DBbase {
  Future<bool> saveUser(UserModel user);
  Future<UserModel> readUser(String userId);
  Future<bool> updateUser(String newUserName, String userId);
  Future<bool> updateProfilePhoto(String userId, String file);
  Future<List<UserModel>> getAllUsers();
  Stream<List<MessageModel>> getMessages(
      String currentUser, String interlocutor);
  Future<void> saveMessage(MessageModel message);
}
