import 'package:flutter_quiz_app/core/base/base_stateless_widget.dart';
import 'package:flutter_quiz_app/core/config/theme/themes.dart';
import 'package:flutter_quiz_app/core/constants/app_constants.dart';
import 'package:flutter_quiz_app/core/service/analytics/analytics.dart';
import 'package:flutter_quiz_app/core/service/routes/app_pages.dart';
import 'package:flutter_quiz_app/core/service/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

Future<void> main() async {
  await initService();
  runApp(MyApp());
}

Future<void> initService() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  WakelockPlus.enable();
  Get.put(AnalyticsService());
  await GetStorage.init();
  Get.put(ThemeService()).init();
}

class MyApp extends BaseStatelessWidget {
  MyApp({super.key});
  final themeService = Get.find<ThemeService>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.rightToLeft,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeService.themeMode,
          title: AppConstants.appName,
          getPages: AppPages.routes,
          initialRoute: AppPages.initial,
          navigatorObservers: [
            Get.find<AnalyticsService>().analyticsObserver,
          ],
        );
      },
    );
  }
}
