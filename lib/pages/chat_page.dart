import 'package:chatapp/models/message_model.dart';
import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/viewmodel/user_viewmodel.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final UserModel user;
  final UserModel interlocutor;
  const ChatPage({super.key, required this.user, required this.interlocutor});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);
    UserModel user = widget.user;
    UserModel interlocutor = widget.interlocutor;
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(120.0),
              child: Material(
                elevation: 1,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(16)),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        widget.interlocutor.profilePic!,
                      ),
                    ),
                    Text(
                      widget.interlocutor.userName!,
                    ),
                  ],
                ),
              )),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<MessageModel>>(
                  stream: userViewModel.getMessages(
                    currentUser: user.userId,
                    interlocutor: interlocutor.userId,
                  ),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        MessageModel currentmessage = snapshot.data![index];
                        return Text(currentmessage.content);
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hintText: "Type a message!",
                        noPadding: true,
                        radius: 25,
                        textEditingController: textEditingController,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: FloatingActionButton(
                        onPressed: () {},
                        elevation: 0,
                        child: const Icon(
                          Icons.send_rounded,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}