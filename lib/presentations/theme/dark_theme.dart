import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.dark,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.profileButtonColorLight,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)))),
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
        unselectedIconTheme: IconThemeData(color: AppColors.greyIconColor)),
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: AppColors.greyIconColor,
        ),
        shadowColor: Colors.black,
        backgroundColor: Colors.black));
