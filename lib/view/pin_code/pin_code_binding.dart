import 'package:flutter_quiz_app/core/controller/pin_code/controller.dart';
import 'package:get/get.dart';

class PinCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PinCodeController());
  }
}
