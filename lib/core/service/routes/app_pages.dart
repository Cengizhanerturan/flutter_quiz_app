import 'package:flutter_quiz_app/core/service/routes/app_routes.dart';
import 'package:flutter_quiz_app/view/announcement/announcement_list/announcement_list.dart';
import 'package:flutter_quiz_app/view/announcement/announcement_list/announcement_list_binding.dart';
import 'package:flutter_quiz_app/view/category/category.dart';
import 'package:flutter_quiz_app/view/category/category_binding.dart';
import 'package:flutter_quiz_app/view/login/login.dart';
import 'package:flutter_quiz_app/view/login/login_binding.dart';
import 'package:flutter_quiz_app/view/pin_code/pin_code.dart';
import 'package:flutter_quiz_app/view/pin_code/pin_code_binding.dart';
import 'package:flutter_quiz_app/view/profile/send_question/send_question_list/send_question_list.dart';
import 'package:flutter_quiz_app/view/profile/send_question/send_question_list/send_question_list_binding.dart';
import 'package:flutter_quiz_app/view/register/register.dart';
import 'package:flutter_quiz_app/view/register/register_binding.dart';
import 'package:flutter_quiz_app/view/score_list/score_list.dart';
import 'package:flutter_quiz_app/view/score_list/score_list_binding.dart';
import 'package:flutter_quiz_app/view/settings/settings.dart';
import 'package:flutter_quiz_app/view/settings/settings_binding.dart';
import 'package:flutter_quiz_app/view/splash/splash.dart';
import 'package:flutter_quiz_app/view/splash/splash_binding.dart';
import 'package:get/get.dart';

class AppPages {
  static String initial = Routes.initial;
  static final routes = [
    GetPage(
      name: Routes.initial,
      page: () => const Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.announcementList,
      page: () => const AnnouncementList(),
      binding: AnnouncementListBinding(),
    ),
    GetPage(
      name: Routes.category,
      page: () => const Category(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const Register(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.pinCode,
      page: () => const PinCode(),
      binding: PinCodeBinding(),
    ),
    GetPage(
      name: Routes.scoreList,
      page: () => const ScoreList(),
      binding: ScoreListBinding(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => const Settings(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.sendQuestionList,
      page: () => const SendQuestionList(),
      binding: SendQuestionListBinding(),
    ),
    GetPage(
      name: Routes.splash,
      page: () => const Splash(),
      binding: SplashBinding(),
    ),
  ];
}
