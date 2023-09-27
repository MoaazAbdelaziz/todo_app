import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = const Color(0xFF5D9CEC);
  static Color backGroundLight = const Color(0xFFDFECDB);
  static Color backGroundDark = const Color(0xFF060E1E);
  static Color greenColor = const Color(0xFF61E757);
  static Color whitColor = Colors.white;
  static Color greyColor = const Color(0xFF363636);
  static Color blackColor = const Color(0xFF383838);
  static Color redColor = const Color(0xFFEC4B4B);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryLight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryLight,
    ),
    scaffoldBackgroundColor: backGroundLight,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: whitColor,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryLight,
      unselectedItemColor: greyColor,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: blackColor,
    appBarTheme: AppBarTheme(
      backgroundColor: blackColor,
    ),
    scaffoldBackgroundColor: backGroundDark,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: whitColor,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: whitColor,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: whitColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: blackColor,
      unselectedItemColor: whitColor,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: blackColor,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    ),
  );
}
