import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smaple_project/src/core/constant/app_string.dart';
import 'package:smaple_project/src/core/constant/image_string.dart';
import 'package:smaple_project/src/core/enum/body_type.dart';
import 'package:smaple_project/src/core/extensions/extensions.dart';
import 'package:smaple_project/src/core/theme/app_color.dart';

import '../../../dependency_injector.dart';
import '../../core/constant/route_string.dart';
import '../../core/util/app_utility.dart';
import '../providers/authentication_provider.dart';

class LoginVC extends StatefulWidget {
  final String? title;
  const LoginVC({Key? key, this.title}) : super(key: key);

  @override
  State<LoginVC> createState() => _LoginVCState();
}

class _LoginVCState extends State<LoginVC> {
  TextEditingController _emailController = TextEditingController(text: 'test@gmail.com');
  TextEditingController _passwordController = TextEditingController(text: '123456789');

  final focus = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final authProvider = sl<AuthenticationProvider>();
  final _formKey = GlobalKey<FormState>();

  void _onLoginPressed() async {
    if(!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    AppUtility.blockLoader(context);
    // await authProvider.loginWithEmailAndPassword(emailAddress: _emailController.text, password: _passwordController.text, deviceToken: "123", deviceType: DeviceType.android);
    // authProvider.login.fold(
    //         (failure) //{},
    //     => Navigator.pop(context),
    //         (success) {
    //   Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(context, RouteString.main,(route) => route.isCurrent);
    // }
    // );
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        title: Text('Login Screen', style: textTheme.bodyLarge!.copyWith(fontSize: 20, fontWeight: FontWeight.w900),),
      ),
      body: Form(
        key: _formKey,
        child: _buildUI()
        ),
    );
  }

  Widget _buildUI() {
    return
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  // color: Colors.white,
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height - 150,
                  margin: EdgeInsets.only(top: 60),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLogoImg(),
                      Container(
                        height: 40, width: MediaQuery.of(context).size.width, margin: EdgeInsets.only(left: 24),
                          child: Text('Login', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0, color: AppColor.primaryColor), textAlign: TextAlign.left,)),
                      Container(
                          width: MediaQuery.of(context).size.width, margin: EdgeInsets.only(left: 24, right: 12),
                          child: Text('Enter your email and password for signing in.', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0, color: Colors.black),)),
                      _buildEmailTF(),
                      _buildPassTF(),
                      _buildForgotPassBtn(),
                      _buildBtn(),
                      Container(
                          height: 40, margin: EdgeInsets.only(top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Dont Have An Account?', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0, color: Colors.black)),
                              Text(' Sign up', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0, color: AppColor.primaryColor)),
                            ],
                          )
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        );

  }

  Widget _buildLogoImg() {
    return Container(
      height: 180, width: 180,
      child: Image(image: ImageString.logo),
    );
  }

  Widget _buildEmailTF() {
    return Container(

      margin: EdgeInsets.only(top: 40),
      width: MediaQuery.of(context).size.width - 80,
      child: TextFormField(
        validator: (value)=>AppUtility.validateEmail(context, value),
        cursorColor: AppColor.primaryColor,
        style: new TextStyle(
            color: Colors.black,
            fontSize: 14.0
        ),
        controller: _emailController,
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.go,
        focusNode: focus,
        decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
            hintText: "Enter Your Email",

        ),
      ),
    );
  }

  Widget _buildPassTF() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width:
      MediaQuery.of(context).size.width - 80,
      child: TextFormField(
        validator: (value)=>AppUtility.validatePassword(context, value),
        style: new TextStyle(
          color: Colors.black,
          fontSize: 14.0,
        ),
        controller: _passwordController,
        autofocus: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        focusNode: focus2,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
             prefixIcon: const Icon(Icons.lock_rounded),
            suffixIcon: IconButton(
                icon: const Icon(Icons.visibility), onPressed: () {
              setState(() {
                _passwordVisible =
                !_passwordVisible;
              });
            }),
            suffixIconColor: AppColor.gray,

            hintText: "Enter Your Password *",
            ),
      ),
    );
  }
  Widget _buildForgotPassBtn() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.only(top: 15),
        child: ElevatedButton(
          onPressed: () {

          },
          child: Text(AppString.forgotPassword.t(context), style: TextStyle(fontSize: 16.0, color: AppColor.primaryColor),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 0
          ),

        ),
      ),
    );
  }
  Widget _buildBtn() {
    return Container(
      margin: EdgeInsets.only(top:70),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 80,
        height: 50.0,
        child: ElevatedButton(
          onPressed: () {
            _onLoginPressed();
          },
          child: Text(
            'SIGN IN',
            style: new TextStyle(fontSize: 18.0),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  25), // <-- Radius
            ),
          ),
        ),
      ),
    );
  }

}
