import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final UserModel user;
  final UserModel interlocutor;
  const ChatPage({super.key, required this.user, required this.interlocutor});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
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
                        backgroundImage:
                            NetworkImage(interlocutor.profilePic!)),
                    Text(interlocutor.userName!),
                  ],
                ),
              )),
          body: Column(
            children: [
              Expanded(
                child: ListView(),
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
