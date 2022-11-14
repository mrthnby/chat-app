import 'package:chatapp/pages/profile_page.dart';
import 'package:chatapp/pages/users_page.dart';
import 'package:chatapp/services/tab_item.dart';
import 'package:chatapp/widgets/custom_button_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.users;
  Map<TabItem, Widget> allPages() {
    return {
      TabItem.profile: const ProfilePage(),
      TabItem.users: const UsersPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return CustomNavigation(
      pageGenerator: allPages(),
      currentTab: _currentTab,
      onTabSelect: (value) {
        setState(() {
          _currentTab = value;
        });
      },
    );
  }
}
