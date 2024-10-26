import 'package:flutter_quiz_app/core/service/remote/user/remote.dart';
import 'package:get/get.dart';

class FollowersController extends GetxController {
  final bool isFollow;
  final String uid;
  FollowersController({required this.uid, required this.isFollow});

  final _userController = Get.find<UserController>();
  var isLoading = false.obs;
  var list = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    await init();
  }

  Future<void> init() async {
    isLoading.value = true;
    if (isMyProfile(uid: uid)) {
      await UserService.getFollow();
      list.clear();
      if (isFollow) {
        list.addAll(_userController.followList);
      } else {
        list.addAll(_userController.followersList);
      }
    } else {
      var response = await UserService.getFollowReturn(uid: uid);
      var data = response.data;
      list.clear();
      if (isFollow) {
        list.addAll(data!['follow_list']);
      } else {
        list.addAll(data!['followers_list']);
      }
    }
    isLoading.value = false;
  }

  bool isMyProfile({required String uid}) {
    return _userController.uid.value == uid;
  }

  bool checkFollow({required String uid}) {
    var isContain = false;
    for (var item in _userController.followList) {
      Map user = item;
      if (user.containsValue(uid)) {
        isContain = true;
      }
    }
    return isContain;
  }

  int checkFollowWithIndex({required String uid}) {
    var isContain = -1;
    for (var i = 0; i < _userController.followList.length; i++) {
      Map user = _userController.followList[i];
      if (user.containsValue(uid)) {
        isContain = i;
      }
    }
    return isContain;
  }

  Future<void> setFollow({required Map user}) async {
    var index = checkFollowWithIndex(uid: user["uid"]);
    if (index != -1) {
      _userController.followList.removeAt(index);
    } else {
      _userController.followList.add(user);
      UserService.sendFollowNotification(uid: user["uid"]);
    }
    await UserService.setFollow(followedUid: user["uid"]);
  }
}
