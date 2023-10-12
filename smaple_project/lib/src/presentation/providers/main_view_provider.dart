import 'package:flutter/cupertino.dart';

import '../../core/enum/bottom_navigation.dart';

class MainViewProvider with ChangeNotifier {

  ///navigation
  BottomNavigation _currentBottomNavigation = BottomNavigation.home;
  BottomNavigation get currentBottomNavigation => _currentBottomNavigation;

  bool get showBottomNavigation=>_currentBottomNavigation==BottomNavigation.home;

  set currentBottomNavigation(BottomNavigation value) {
    _currentBottomNavigation = value;
    notifyListeners();
  }

  ///side Drawer
  DrawerItem _currentDrawerItem= DrawerItem.home;
  DrawerItem get currentDrawerItem => _currentDrawerItem;
  bool get showAppBarDrawer=>_currentDrawerItem == DrawerItem.home;
  set currentDrawerItem(DrawerItem value) {
    _currentDrawerItem = value;
    notifyListeners();
  }



}