import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          "Chats",
          style: TextStyle(color: Colors.purple),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<ChatModel>>(
        future: userViewModel.getConversations(userViewModel.user!.userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<ChatModel> conversations = snapshot.data!;
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                ChatModel currentChat = conversations[index];
                return Center(child: Text(currentChat.lastMessage));
              },
            );
          }
        },
      ),
    );
  }
}
