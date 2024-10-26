import 'package:flutter_quiz_app/core/controller/change_user_info/controller.dart';
import 'package:get/get.dart';

class ChangeUserInfoBinding implements Bindings {
  final String profileTag;
  ChangeUserInfoBinding({required this.profileTag});

  @override
  void dependencies() {
    Get.put(ChangeUserInfoController(profileTag: profileTag));
  }
}
