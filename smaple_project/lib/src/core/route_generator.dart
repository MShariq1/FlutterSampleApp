
import 'package:flutter/material.dart';
import 'package:smaple_project/src/presentation/auth_views/LoginVC.dart';
import '../presentation/main_view/MainView.dart';
import '../presentation/main_view/notification/notification.dart';
import '../presentation/splash_view/SpalshView.dart';
import 'constant/route_string.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
// Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case RouteString.splash:
        return MaterialPageRoute(builder: (_)=>const SplashView());
        case RouteString.main:
        return MaterialPageRoute(builder: (_)=>const MainView());
        case RouteString.login:
        return MaterialPageRoute(builder: (_)=>const LoginVC());
        case RouteString.notification:
        return MaterialPageRoute(builder: (_)=>const NotificationVC());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
