import 'package:flutter_quiz_app/core/config/theme/app_colors.dart';
import 'package:flutter_quiz_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final ThemeData lightTheme = ThemeData.light().copyWith();

final ThemeData darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  cardColor: AppColors.primaryCardColor,
  canvasColor: AppColors.secondaryCardColor,
  indicatorColor: AppColors.primaryColor,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  primaryColorDark: AppColors.primaryBlackColor,
  primaryColorLight: AppColors.primaryWhiteColor,
  disabledColor: AppColors.primaryGreyColor,
  dividerColor: AppColors.dividerColor,
  inputDecorationTheme: InputDecorationTheme(
    counterStyle: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 16.0.sp,
      letterSpacing: 0.5,
      color: AppColors.primaryGreyColor,
    ),
  ),
  switchTheme: const SwitchThemeData(
    trackColor: WidgetStatePropertyAll(AppColors.backgroundColor),
    trackOutlineColor: WidgetStatePropertyAll(AppColors.primaryCardColor),
  ),
  iconTheme: IconThemeData(
    size: 16.px,
    color: AppColors.primaryColor,
  ),
  primaryIconTheme: IconThemeData(
    size: 16.px,
    color: AppColors.primaryColor,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primaryColor,
    selectionHandleColor: AppColors.primaryColor,
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 19.0.sp,
      letterSpacing: 0.25,
      color: AppColors.primaryWhiteColor,
    ),
    titleLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 21.0.sp,
      letterSpacing: 0.25,
      color: AppColors.primaryWhiteColor,
    ),
    titleMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 19.0.sp,
      letterSpacing: 0.25,
      color: AppColors.primaryWhiteColor,
    ),
    titleSmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 17.5.sp,
      letterSpacing: 0.75,
      color: AppColors.primaryWhiteColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 18.0.sp,
      letterSpacing: 0.5,
      color: AppColors.primaryWhiteColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 17.0.sp,
      letterSpacing: 0.5,
      color: AppColors.primaryWhiteColor,
    ),
    bodySmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 16.0.sp,
      letterSpacing: 0.5,
      color: AppColors.primaryWhiteColor,
    ),
    labelLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColors.primaryWhiteColor,
    ),
    labelMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 14.0.sp,
      letterSpacing: 0.5,
      color: AppColors.primaryWhiteColor,
    ),
    labelSmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 13.0.sp,
      letterSpacing: 0.5,
      color: AppColors.primaryWhiteColor,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(error: Colors.red)
      .copyWith(brightness: Brightness.dark)
      .copyWith(surface: AppColors.backgroundColor),
);
