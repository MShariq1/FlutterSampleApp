import 'package:flutter/material.dart';
import 'package:smaple_project/sampleApp.dart';
import 'dependency_injector.dart' as injector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector.setup();
  runApp(const sampleApp());
}