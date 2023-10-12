import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smaple_project/src/core/extensions/extensions.dart';
import 'package:smaple_project/src/core/theme/app_color.dart';

import '../constant/app_string.dart';
import '../constant/route_string.dart';

abstract class AppUtility {
  static const verticalSpacing = 20.0;
  static const horizontalSpacing = 20.0;
  static final ImagePicker _imagePicker = ImagePicker();

  static String? validateName(BuildContext context, dynamic value) {
    if (value == null || value.isEmpty) {
      return AppString.emptyField;
    }
    if (value.length < 3) {
      return AppString.registerNameLength;
    }
    RegExp regExpDD = RegExp(
      r"^[0-9]*$",
      caseSensitive: false,
    );
    if (regExpDD.hasMatch(value)) {
      //todo arabic
      return AppString.alphaCharacter.t(context);
    }
    return null;
  }

  static String? validateSubject(BuildContext context, dynamic value) {
    if (value == null || value.isEmpty) {
      return AppString.emptyField;
    }
    if (value.length < 3) {
      return AppString.registerNameLength;
    }
    RegExp regExpDD = RegExp(
      r"^[0-9]*$",
      caseSensitive: false,
    );
    if (regExpDD.hasMatch(value)) {
      //todo arabic
      return AppString.alphaCharacter.t(context);
    }
    return null;
  }

  static String? validateMessage(BuildContext context, dynamic value) {
    if (value == null || value.isEmpty) {
      return AppString.emptyField;
    }
    if (value.length < 3) {
      return AppString.registerMessageLength;
    }
    RegExp regExpDD = RegExp(
      r"^[0-9]*$",
      caseSensitive: false,
    );
    if (regExpDD.hasMatch(value)) {
      //todo arabic
      return AppString.alphaCharacter.t(context);
    }
    return null;
  }

  static String? validatePassword(BuildContext context, dynamic value) {
    if (value == null || value.isEmpty) {
      return AppString.emptyField;
    }
    if (value.length < 8) {
      return AppString.registerMinPassword.t(context);
    }
    if (value.length > 20) {
      return AppString.registerMaxPassword.t(context);
    }
    return null;
  }

  static String? validateConfirmPassword(
      BuildContext context, dynamic value, String password) {
    if (value == null || value.isEmpty) {
      return AppString.emptyField;
    }
    if (value != password) {
      return AppString.registerPasswordMatch.t(context);
    }

    return null;
  }

  static String? validatePhoneNumber(BuildContext context, dynamic value) {
    if (value == null || value.isEmpty) {
      return AppString.emptyField;
    }
    if (value.length < 7) {
      return AppString.ValidPhoneNumber.t(context);
    }
    if (value.length > 15) {
      return AppString.ValidPhoneNumber.t(context);
    }
    return null;
  }

  static String? validateEmail(BuildContext context, dynamic value) {
    if (value == null || value.isEmpty) {
      return AppString.emptyField;
    }
    if (!RegExp(r"^((?!\.)[\w_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$")
        .hasMatch(value)) {
      return AppString.registerValidEmail;
    }

    return null;
  }

  static String? validationDate(BuildContext context, dynamic value) {
    if (value == null || value.isEmpty) {
      return AppString.emptyField;
    }
    // if(!_isAdult(value)){
    //   return AppString.registerDoB.t(context);
    // }
    return null;
  }

  ///image picker
  static Future<XFile?> pickImage() async {
    final XFile? xFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    return xFile;
  }

  static const emptyBox = SizedBox.shrink();
  static const adaptiveLoader =
      Center(child: CircularProgressIndicator.adaptive());

  static dateFormatter(String value) {
    String datePattern = "MM/dd/yyyy";

    //DateTime birthDate = DateFormat(datePattern).parse(value);
    DateFormat format = DateFormat("MMMM dd, yyyy");

    try {
      return format
          .format((DateTime.tryParse(value) ?? DateTime.now()).toLocal());
    } catch (e) {
      return "";
    }
  }

  static String dateMonth(String value) {
    String datePattern = "MM";

    //DateTime birthDate = DateFormat(datePattern).parse(value);
    DateFormat format = DateFormat("MMMM");

    try {
      return format
          .format((DateTime.tryParse(value) ?? DateTime.now()).toLocal());
    } catch (e) {
      return "";
    }
  }

  static dateDay(String value) {
    String datePattern = "dd";

    //DateTime birthDate = DateFormat(datePattern).parse(value);
    DateFormat format = DateFormat("dd");

    try {
      return format.format((DateTime.tryParse(value) ?? DateTime.now()).toLocal());
    } catch (e) {
      return "";
    }
  }
  static (int days, int hours,int minutes,int seconds) timerCountDown({required String dateTime}){
  DateFormat daysFormat = DateFormat("dd");
  DateFormat hoursFormat = DateFormat("HH");
  DateFormat minutesFormat = DateFormat("mm");
  DateFormat secondsFormat = DateFormat("ss");
  int days = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  try {
  days =  int.parse(daysFormat.format((DateTime.tryParse(dateTime) ?? DateTime.now()).toLocal()));
  } catch (e) {
  days =  0;
  }
  try {
  hours =  int.parse(hoursFormat.format((DateTime.tryParse(dateTime) ?? DateTime.now()).toLocal()));
  } catch (e) {
  hours =  0;
  }
  try {
  minutes =  int.parse(minutesFormat.format((DateTime.tryParse(dateTime) ?? DateTime.now()).toLocal()));
  } catch (e) {
  minutes =  0;
  }
  try {
  seconds =  int.parse(secondsFormat.format((DateTime.tryParse(dateTime) ?? DateTime.now()).toLocal()));
  } catch (e) {
  seconds =  0;
  }

  return (days,hours,minutes,seconds);
  }

  static timeFormatter(String date) {
    DateFormat dateFormatter = DateFormat("hh:mm a");
    try {
      return dateFormatter
          .format((DateTime.tryParse(date) ?? DateTime.now()).toLocal());
    } catch (e) {
      return "";
    }
  }

  // static distance(String distance){
  //   var mileFromMeter;
  //   try{
  //     mileFromMeter = (distance) / (1609.344);
  //   }catch (e) {
  //     return "";
  //   }
  //
  // }
  static showToast({required String message})=>Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0
  );
  static showAuthenticatedDialog(BuildContext context) async {
    return await showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Wrap(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 34),
                padding: const EdgeInsets.only(top: 24),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "In order to continue please login",
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColor.primaryColor),
                            )),
                        TextButton(
                            onPressed: () async {
                              Future.microtask(() => Navigator.popAndPushNamed(
                                  context, RouteString.login));
                            },
                            child: Text(
                              'Ok',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColor.primaryColor),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  static blockLoader(BuildContext context)=>showDialog(context: context, builder: (_)=>WillPopScope(onWillPop: ()async=>false, child: AppUtility.adaptiveLoader),barrierDismissible: false);
}

class ImageUtils {
  static Future<List<dynamic>> preloadNetworkImages(
      BuildContext context, List<String> imageUrls) async {
    List<dynamic> exceptions = [];

    await Future.wait(imageUrls.map((e) => precacheImage(
          NetworkImage(e),
          context,
          onError: (exception, stackTrace) {
            exceptions.add(exception);
          },
        )));
    return Future.value(exceptions);
  }
}
