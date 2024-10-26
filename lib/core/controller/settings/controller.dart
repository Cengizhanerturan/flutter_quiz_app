import 'package:flutter_quiz_app/core/constants/string_constants.dart';
import 'package:flutter_quiz_app/core/controller/app/controller.dart';
import 'package:flutter_quiz_app/core/controller/audio/controller.dart';
import 'package:flutter_quiz_app/core/service/cache/cache.dart';
import 'package:flutter_quiz_app/core/service/notification/notification_service.dart';
import 'package:flutter_quiz_app/core/service/remote/user/remote.dart';
import 'package:flutter_quiz_app/core/service/routes/app_routes.dart';
import 'package:flutter_quiz_app/core/util/get_extension.dart';
import 'package:flutter_quiz_app/core/util/helper.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final _userController = Get.find<UserController>();
  final _appController = Get.find<AppController>();
  final _cacheService = Get.find<CacheService>();
  final _audioController = Get.find<AudioController>();
  final _notificationService = Get.find<NotificationService>();

  var isLoading = false.obs;

  bool get getOpenSound => _audioController.getIsOpenSound;

  Future<void> setOpenSound(bool isOpen) async {
    await _audioController.setIsOpenSound(isOpen);
  }

  bool get getOpenNotification => _notificationService.getIsOpenNotification;

  Future<void> setOpenNotification(bool isOpen) async {
    if (isOpen) {
      await _notificationService.allSubscribeChannel();
    } else {
      await _notificationService.allUnsubscribeChannel();
    }
  }

  Future<void> logOut() async {
    logoutDialog().then((value) async {
      if (value) {
        isLoading.value = true;
        if (_cacheService.box.hasData('uid')) {
          await _cacheService.box.remove('uid');
        }
        await _notificationService.logOut();
        _userController.logOut();
        isLoading.value = false;
        Get.offAllNamed(Routes.home);
        _notificationService.isOpenNotification.value = true;
      }
    });
  }

  Future<void> disableUser() async {
    try {
      disableUserDialog().then((value) async {
        if (value) {
          isLoading.value = true;
          var responseModel =
              await UserService.disableUser(uid: _userController.uid.value);
          if (responseModel.status == 'success') {
            if (_cacheService.box.hasData('uid')) {
              await _cacheService.box.remove('uid');
            }
            await _notificationService.logOut();
            _userController.logOut();
            isLoading.value = false;
            Get.offAllNamed(Routes.home);
            _notificationService.isOpenNotification.value = true;
            await Helper.openDialog(
                dialog: CustomDialog(
                    status: responseModel.status,
                    message: responseModel.message!));
          } else {
            await Helper.openDialog(
                dialog: CustomDialog(
                    status: responseModel.status,
                    message: responseModel.message!));
          }
        }
      });
    } catch (e) {
      await Helper.openDialog(
          dialog: const CustomDialog(
              status: 'error', message: StringConstants.errorText));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openPrivacyPolicyUrl() async {
    await Get.launchURL(_appController.privacyPolicyUrl.value);
  }
}
