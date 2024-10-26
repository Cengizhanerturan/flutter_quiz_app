import 'package:flutter_quiz_app/core/constants/enums.dart';
import 'package:flutter_quiz_app/core/controller/register/controller.dart';
import 'package:flutter_quiz_app/core/controller/settings/change_email_controller.dart';
import 'package:flutter_quiz_app/core/controller/settings/change_password_controller.dart';
import 'package:flutter_quiz_app/core/controller/settings/change_username_controller.dart';
import 'package:flutter_quiz_app/core/service/remote/register/remote.dart';
import 'package:flutter_quiz_app/core/service/remote/user/remote.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';

class PinCodeController extends GetxController {
  late final RegisterController _registerController;
  late final ChangeEmailController _changeEmailController;
  late final ChangeUsernameController _changeUsernameController;
  late final ChangePasswordController _changePasswordController;
  CountDownController countdownController = CountDownController();
  var reSendCode = false.obs;
  var isLoading = false.obs;
  var pinCode = ''.obs;

  PinCodeType get getType => Get.arguments["pinCodeType"] as PinCodeType;

  var canBack = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeController();
  }

  void initializeController() {
    if (getType == PinCodeType.register) {
      _registerController = Get.find<RegisterController>();
    } else if (getType == PinCodeType.changeEmail) {
      _changeEmailController = Get.find<ChangeEmailController>();
    } else if (getType == PinCodeType.changeUsername) {
      _changeUsernameController = Get.find<ChangeUsernameController>();
    } else {
      _changePasswordController = Get.find<ChangePasswordController>();
    }
  }

  Future<void> getResendCodeFunction() async {
    if (getType == PinCodeType.register) {
      await RegisterService.resendCode(id: _registerController.mailID.value);
    } else if (getType == PinCodeType.changeEmail) {
      await UserService.changeEmailResendCode(
          id: _changeEmailController.mailID.value);
    } else if (getType == PinCodeType.changeUsername) {
      await UserService.changeUsernameResendCode(
          id: _changeUsernameController.mailID.value);
    } else {
      await UserService.changePasswordResendCode(
          id: _changePasswordController.mailID.value);
    }
  }

  Future<void> getConfirmFunction({required String code}) async {
    if (getType == PinCodeType.register) {
      await registerConfirm(code: code);
    } else if (getType == PinCodeType.changeEmail) {
      await changeEmailConfirm(code: code);
    } else if (getType == PinCodeType.changeUsername) {
      await changeUsernameConfirm(code: code);
    } else {
      await changePasswordConfirm(code: code);
    }
  }

  Future<void> onPopInvokedWithResult(bool didPop, Object? result) async {
    if (didPop) {
      return;
    }
    bool check = await pinCodeExitDialog(message: getDialogMessage());
    if (check) {
      canBack.value = true;
      Get.back();
    }
  }
}
