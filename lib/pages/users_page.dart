import 'package:chatapp/models/user_model.dart';
import 'package:chatapp/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<UserModel>>(
          future: _userViewModel.getAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length - 1 > 0) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    UserModel currentUser = snapshot.data![index];
                    return ListTile(
                      title: Text(currentUser.userName!),
                      leading: CircleAvatar(
                          backgroundImage: currentUser.profilePic! != ""
                              ? NetworkImage(currentUser.profilePic!)
                              : Image.asset("assets/profile_pic.jpg").image),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("There is no user logged into the system."),
                );
              }
            } else {
              return const Center(
                child: Text("An error occurred while retrieving user data"),
              );
            }
          },
        ),
      ),
    );
  }
}
