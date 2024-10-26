import 'package:flutter_quiz_app/core/controller/profile/controller.dart';
import 'package:flutter_quiz_app/core/service/remote/user/remote.dart';
import 'package:flutter_quiz_app/core/util/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeUserInfoController extends GetxController {
  final String profileTag;

  ChangeUserInfoController({required this.profileTag});

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  FocusNode nameFocusNode = FocusNode();
  FocusNode surnameFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();
  final changeUserInfoKey = GlobalKey<FormState>();

  final _userController = Get.find<UserController>();

  var isLoading = false.obs;
  var isSet = false.obs;

  @override
  void onInit() {
    setDefault();
    super.onInit();
  }

  @override
  void onClose() {
    setDefault();
    super.onClose();
  }

  void getBack() {
    Get.find<ProfileController>(tag: profileTag).isChange.value = isSet.value;
    Get.back();
    setDefault();
  }

  Future<void> onPopInvokedWithResult(bool didPop, Object? result) async {
    Get.find<ProfileController>(tag: profileTag).isChange.value = isSet.value;
    setDefault();
  }

  void setDefault() {
    nameController.text = _userController.name.value;
    surnameController.text = _userController.surname.value;
    bioController.text = _userController.bio.value;
    isSet.value = false;
  }

  Future<void> setUserInfo() async {
    if (isLoading.value == false) {
      isLoading.value = true;
      var response = await UserService.setUserInfo(
          uid: _userController.uid.value,
          name: nameController.text,
          surname: surnameController.text,
          bio: bioController.text);
      if (response.status == 'success') {
        await UserService.user(uid: _userController.uid.value);
        isLoading.value = false;
        isSet.value = true;
        await Helper.openDialog(
            dialog: CustomDialog(
                status: response.status, message: response.message!));
      } else {
        isLoading.value = false;
        await Helper.openDialog(
            dialog: CustomDialog(
                status: response.status, message: response.message!));
      }
    }
  }
}
