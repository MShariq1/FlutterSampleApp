import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaple_project/src/presentation/main_view/home_body/exams_body/exams_body.dart';

import '../../providers/main_view_provider.dart';
import 'account_body/account_body.dart';
import 'home_body/home_body.dart';

class HomeBodyTemp extends StatefulWidget {
  final VoidCallback drawerCallBack;
  const HomeBodyTemp({Key? key,required this.drawerCallBack}) : super(key: key);

  @override
  State<HomeBodyTemp> createState() => _HomeBodyTempState();
}

class _HomeBodyTempState extends State<HomeBodyTemp> {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mainViewProvider = Provider.of<MainViewProvider>(context);
    final currentBottomNavigation = mainViewProvider.currentBottomNavigation;
    return Column(
      children: [
        Expanded(
          child:  [
            HomeBody(openDrawer: widget.drawerCallBack),
            ExamsBody(),
            AccountBody(openDrawer: widget.drawerCallBack),
          ].elementAt(currentBottomNavigation.index),
        ),

      ],
    );
  }
}
