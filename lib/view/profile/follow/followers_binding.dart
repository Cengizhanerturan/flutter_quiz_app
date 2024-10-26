import 'package:flutter_quiz_app/core/controller/followers/controller.dart';
import 'package:get/get.dart';

class FollowersBinding implements Bindings {
  final String uid;
  final bool isFollow;
  final String tag;

  FollowersBinding(
      {required this.uid, required this.isFollow, required this.tag});

  @override
  void dependencies() {
    Get.put(FollowersController(uid: uid, isFollow: isFollow));
  }
}
