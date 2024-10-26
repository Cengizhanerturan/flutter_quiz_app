import 'package:flutter_quiz_app/core/constants/enums.dart';
import 'package:flutter_quiz_app/core/service/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper {
  static Future? getToPinCodePage({required PinCodeType pinCodeType}) {
    return Get.toNamed(Routes.pinCode, arguments: {"pinCodeType": pinCodeType});
  }

  static Future openDialog({required Widget dialog}) async {
    return await Get.dialog(
      barrierColor: Colors.black87.withOpacity(0.7),
      dialog,
    );
  }
}
