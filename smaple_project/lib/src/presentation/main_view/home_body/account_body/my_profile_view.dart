import 'package:flutter/material.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({Key? key}) : super(key: key);

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Profile'),
    );
  }
}
