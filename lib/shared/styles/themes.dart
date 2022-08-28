import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/shared/components/constants.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 55,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    // unselectedItemColor: Colors.grey,
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: HexColor("333739"),
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor("333739"),
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor("333739"),
      statusBarIconBrightness: Brightness.light,
    ),
    titleSpacing: 20,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 55,
    backgroundColor: HexColor("333739"),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
  ),
);
