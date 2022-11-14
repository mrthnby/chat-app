import 'package:flutter/material.dart';

enum TabItem { profile, users }

class TabItemData {
  final String title;
  final Icon icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem, TabItemData> allTabs = {
    TabItem.users: TabItemData(
      "Users",
      const Icon(Icons.people_rounded),
    ),
    TabItem.profile: TabItemData(
      "Profile",
      const Icon(Icons.account_circle_rounded),
    )
  };
}
