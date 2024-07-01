import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  backgroundColor: AppColors.lightContainerBackground,
  scaffoldBackgroundColor: AppColors.white,
  brightness: Brightness.light,
  fontFamily: "PlusJakarta",
  primarySwatch: Colors.purple,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  // primaryColor: Colors.purple,
  useMaterial3: false,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.white,
    selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
    unselectedIconTheme: IconThemeData(color: AppColors.greyIconColor),
  ),
  dividerColor: AppColors.greyIconColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.profileButtonColorLight,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.black)),
  appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: AppColors.greyIconColor),
      shadowColor: Colors.transparent,
      backgroundColor: Colors.white),
);


    // theme: ThemeData(
    //   primarySwatch: Colors.purple,
    //   visualDensity: VisualDensity.adaptivePlatformDensity,
    //   primaryColor: AppColors().c.blinqpay,
    //   fontFamily: "PlusJakarta",
    //   useMaterial3: false,
    // ),