import 'package:flutter/cupertino.dart';

import '../constant/image_string.dart';

enum BottomNavigation {
  home('Home', ImageString.home),
  notifications('Exams', ImageString.events),
  account('Account', ImageString.account);

  final String name;
  final ImageProvider image;

  const BottomNavigation(this.name, this.image);
}

enum DrawerItem {
  home('Home', ImageString.home),
  profile('Profile', ImageString.account),
  login('Login', ImageString.logOut),
  logout('logout', ImageString.logOut);

  final String name;
  final ImageProvider image;

  const DrawerItem(this.name, this.image);
}