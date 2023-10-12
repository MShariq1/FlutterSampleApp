import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smaple_project/src/core/theme/app_color.dart';

import '../../core/constant/image_string.dart';
import '../../core/constant/route_string.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late final Timer _timer;
  static const _duration = Duration(milliseconds: 2300);
  late final AnimationController _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2000))..repeat();

  @override
  void initState() {
    super.initState();
    _timer = Timer(_duration, () {
      _controller.dispose();
      Navigator.pushReplacementNamed(context, RouteString.login);
    });
  }

  @override
  void dispose() {
    // _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: child,
              );
            },
            child:
            FlutterLogo(size: 70),
          ),
          SizedBox(height: 150,),
          Text('Sample App', style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 24)), //TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),)
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 50),
            child: new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2000,
              percent: 1,
              // center: Text("90.0%"),
              barRadius: const Radius.circular(16),
              progressColor: AppColor.primaryColor,
            ),
          )
        ],

      ),
    );
  }
}