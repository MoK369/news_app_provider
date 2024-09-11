import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static const Color lightPrimaryColor = Color(0xFFFFFFFF);
  static const Color lightOnPrimaryColor = Color(0xFF39A552);
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: lightPrimaryColor,
      cardColor: lightOnPrimaryColor,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: lightOnPrimaryColor),
      dividerColor: Colors.black,
      appBarTheme: AppBarTheme(
          backgroundColor: lightOnPrimaryColor,
          foregroundColor: lightPrimaryColor,
          centerTitle: true,
          iconTheme: const IconThemeData(size: 35, color: lightPrimaryColor),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: lightOnPrimaryColor,
              statusBarBrightness: Brightness.light),
          titleTextStyle: GoogleFonts.exo(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          )),
      drawerTheme: const DrawerThemeData(backgroundColor: lightPrimaryColor),
      textTheme: TextTheme(
          bodyMedium: GoogleFonts.alice(
              color: const Color(0xFF42505C),
              fontSize: 25,
              fontWeight: FontWeight.w400),
          labelMedium: GoogleFonts.poppins(
              color: const Color(0xFF42505C),
              fontSize: 25,
              fontWeight: FontWeight.w500),
          displayMedium: GoogleFonts.poppins(
              color: lightOnPrimaryColor,
              fontSize: 25,
              fontWeight: FontWeight.w500),
          //for sources name
          labelSmall: GoogleFonts.poppins(
              color: const Color(0xFF79828B),
              fontSize: 15,
              fontWeight: FontWeight.w400),
          titleMedium: GoogleFonts.poppins(
              color: lightPrimaryColor,
              fontSize: 25,
              fontWeight: FontWeight.w500)),
      dropdownMenuTheme: const DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
            suffixIconColor: lightOnPrimaryColor,
            fillColor: lightPrimaryColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: lightOnPrimaryColor, width: 2))),
        menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(lightPrimaryColor),
            elevation: WidgetStatePropertyAll(0),
            surfaceTintColor: WidgetStatePropertyAll(Colors.transparent)),
        textStyle: TextStyle(color: Colors.black, fontSize: 20),
      ),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightPrimaryColor,
          prefixIconColor: lightOnPrimaryColor,
          suffixIconColor: lightOnPrimaryColor,
          hintStyle: const TextStyle(fontSize: 25, color: lightOnPrimaryColor),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: lightOnPrimaryColor),
              borderRadius: BorderRadius.circular(30))));

  static const Color darkPrimaryColor = Color(0xFF121212);
  static const Color darkOnPrimaryColor = Color(0xFF1ed760);
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: darkPrimaryColor,
      cardColor: darkOnPrimaryColor,
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: darkOnPrimaryColor),
      dividerColor: Colors.white,
      appBarTheme: AppBarTheme(
          backgroundColor: darkOnPrimaryColor,
          foregroundColor: darkPrimaryColor,
          centerTitle: true,
          iconTheme: const IconThemeData(size: 35, color: darkPrimaryColor),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: darkOnPrimaryColor,
              statusBarBrightness: Brightness.dark),
          titleTextStyle: GoogleFonts.exo(
              color: darkPrimaryColor,
              fontSize: 25,
              fontWeight: FontWeight.w500)),
      drawerTheme: const DrawerThemeData(backgroundColor: darkPrimaryColor),
      textTheme: TextTheme(
          bodyMedium: GoogleFonts.alice(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
          labelMedium: GoogleFonts.poppins(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
          labelSmall: GoogleFonts.poppins(
              color: const Color(0xFF79828B),
              fontSize: 15,
              fontWeight: FontWeight.w400),
          displayMedium: GoogleFonts.poppins(
              color: darkOnPrimaryColor,
              fontSize: 25,
              fontWeight: FontWeight.w500),
          titleMedium: GoogleFonts.poppins(
              color: darkPrimaryColor,
              fontSize: 25,
              fontWeight: FontWeight.w500)),
      dropdownMenuTheme: const DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
            suffixIconColor: darkOnPrimaryColor,
            fillColor: darkPrimaryColor,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: darkOnPrimaryColor, width: 2))),
        menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
            elevation: WidgetStatePropertyAll(0),
            surfaceTintColor: WidgetStatePropertyAll(Colors.transparent)),
        textStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkPrimaryColor,
          prefixIconColor: darkOnPrimaryColor,
          suffixIconColor: darkOnPrimaryColor,
          hintStyle: const TextStyle(fontSize: 25, color: darkOnPrimaryColor),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: darkOnPrimaryColor),
              borderRadius: BorderRadius.circular(30))));
}
