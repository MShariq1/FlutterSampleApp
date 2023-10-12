import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

abstract class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = _buildShrineTheme();
  static ThemeData darkTheme = _darkTheme;
}

ThemeData _darkTheme = ThemeData.dark();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primaryColor,
      primary: AppColor.primaryColor
    ),
    useMaterial3: true,
    textTheme: GoogleFonts.interTextTheme().copyWith(
      bodyMedium: GoogleFonts.inter().copyWith(color: AppColor.blackText),
      bodyLarge: GoogleFonts.inter().copyWith(color: AppColor.blackText),
      bodySmall: GoogleFonts.inter().copyWith(color: AppColor.blackText),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          // color: Color(0xff8DB6C6),
            color: AppColor.inActiveGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColor.primaryColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      prefixIconColor: AppColor.primaryColor,
      hintStyle: GoogleFonts.interTextTheme().bodyMedium?.copyWith(
          color: AppColor.textFieldHint,
          fontWeight: FontWeight.w300,
          fontSize: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: AppColor.blackText,
        foregroundColor: AppColor.white,
        fixedSize: const Size.fromHeight(64.0),
        textStyle: GoogleFonts.interTextTheme().bodyMedium?.copyWith(
            color: AppColor.white, fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        //  backgroundColor: AppColor.blackText,
        foregroundColor: AppColor.blackText,
        fixedSize: const Size.fromHeight(64.0),
        textStyle: GoogleFonts.interTextTheme().bodyMedium?.copyWith(
            color: AppColor.white, fontWeight: FontWeight.w600, fontSize: 16),
      ),
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: AppColor.white),
    ),
  );
}

// {
// FontWeight.w100: 'Thin',
// FontWeight.w200: 'ExtraLight',
// FontWeight.w300: 'Light',
// FontWeight.w400: 'Regular',
// FontWeight.w500: 'Medium',
// FontWeight.w600: 'SemiBold',
// FontWeight.w700: 'Bold',
// FontWeight.w800: 'ExtraBold',
// FontWeight.w900: 'Black',
// }
