import 'package:flutter_quiz_app/core/model/user_info.dart';
import 'package:flutter_quiz_app/core/service/remote/user/remote.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController with StateMixin {
  final bool isMyProfile;
  final String uid;

  ProfileController({
    required this.isMyProfile,
    required this.uid,
  });

  final _userController = Get.find<UserController>();
  late UserInfoModel userInfoModel;
  var followCount = 0.obs;
  var followersCount = 0.obs;

  var isChange = false.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    try {
      change(state, status: RxStatus.loading());
      var userInfoResponse = await UserService.userInfo(uid: uid);
      if (userInfoResponse.status == 'success') {
        userInfoModel = UserInfoModel.fromMap(userInfoResponse.data!);
        await UserService.getFollow();
        if (!isMyProfile) {
          followCount.value = userInfoModel.followCount;
          followersCount.value = userInfoModel.followersCount;
        }
      } else {
        change(state, status: RxStatus.error());
        return;
      }
      change(state, status: RxStatus.success());
    } catch (e) {
      change(state, status: RxStatus.error());
    }
  }

  Future<void> getUserInfo() async {
    var userInfoResponse = await UserService.userInfo(uid: uid);
    if (userInfoResponse.status == 'success') {
      userInfoModel = UserInfoModel.fromMap(userInfoResponse.data!);
      update();
    }
  }

  int getFollowersCount() {
    if (isMyProfile) {
      return _userController.followersCount.value;
    } else {
      return followersCount.value;
    }
  }

  int getFollowCount() {
    if (isMyProfile) {
      return _userController.followCount.value;
    } else {
      return followCount.value;
    }
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

  Future<void> setFollow() async {
    var index = checkFollowWithIndex();
    if (index != -1) {
      _userController.followList.removeAt(index);
      followersCount.value--;
    } else {
      _userController.followList.add({
        'uid': userInfoModel.uid,
        'username': userInfoModel.username,
        'profile_image': userInfoModel.profileImage
      });
      followersCount.value++;
      UserService.sendFollowNotification(uid: uid);
    }
    await UserService.setFollow(followedUid: uid);
  }

  String getProfileImage() {
    if (isMyProfile) {
      return _userController.profileImage.value;
    } else {
      return userInfoModel.profileImage!;
    }
  }
}
