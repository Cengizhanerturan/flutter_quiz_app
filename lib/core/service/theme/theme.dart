import 'dart:io';
import 'package:flutter_quiz_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ThemeService extends GetxService {
  late ThemeMode themeMode;

  void init() {
    getTheme();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness:
            Platform.isIOS ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: AppColors.backgroundColor));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void getTheme() {
    themeMode = ThemeMode.dark;
  }
}
