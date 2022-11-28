import 'package:chatapp/models/chat_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
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
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
                await Future.delayed(
                  const Duration(
                    seconds: 1,
                  ),
                );
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3),
                physics: const AlwaysScrollableScrollPhysics(),
                child: const Center(
                  child: Text(
                    "There is no messages to see, go to users page and start to chat with someone",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          } else {
            List<ChatModel> conversations = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {});
                await Future.delayed(
                  const Duration(
                    seconds: 1,
                  ),
                );
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                itemCount: conversations.length,
                itemBuilder: (context, index) {
                  ChatModel currentChat = conversations[index];
                  UserModel currentSpoken =
                      userViewModel.getUserFromCache(currentChat.interlocutor);
                  return GestureDetector(
                    onTap: () =>
                        Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          user: userViewModel.user!,
                          interlocutor: currentSpoken,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(currentSpoken.profilePic!),
                      ),
                      title: Text(currentSpoken.userName!),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(currentChat.lastMessage),
                          Text(currentChat.timeDiff),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
