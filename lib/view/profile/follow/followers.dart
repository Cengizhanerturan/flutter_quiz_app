import 'package:flutter_quiz_app/core/base/base_get_view.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/core/controller/followers/controller.dart';
import 'package:flutter_quiz_app/widgets/custom_appbar.dart';
import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:flutter_quiz_app/widgets/profile_photo.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_autosize_text.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class Followers extends BaseGetView<FollowersController> {
  final String uid;
  final String controllerTag;
  final bool isFollow;
  const Followers(
      {Key? key,
      required this.uid,
      required this.controllerTag,
      required this.isFollow})
      : super(key: key);

  @override
  String get tag => controllerTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FollowersController>(
      init: FollowersController(uid: uid, isFollow: isFollow),
      dispose: (val) {
        Get.delete<FollowersController>(tag: tag);
      },
      tag: controllerTag,
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            title: controller.isFollow ? 'Takip' : 'Takipçi',
          ),
          body: SafeArea(
            child: buildBody(controller),
          ),
        );
      },
    );
  }

  Widget buildBody(FollowersController controller) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          12.height,
          buildList(controller: controller, list: controller.list),
        ],
      ),
    );
  }

  Widget buildList(
      {required FollowersController controller, required List list}) {
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var user = list[index];
          return Column(
            children: [
              buildCard(controller: controller, user: user),
              12.height,
            ],
          );
        },
      ).paddingSymmetric(horizontal: 16.0),
    );
  }

  Widget buildCard(
      {required FollowersController controller, required Map user}) {
    return CustomInkWell(
      onTap: () {},
      child: ClayContainer(
        borderRadius: 16.0,
        color: theme.cardColor,
        parentColor: theme.scaffoldBackgroundColor,
        depth: 10,
        spread: 1,
        curveType: CurveType.concave,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildImage(user),
                  8.width,
                  Expanded(child: buildUsername(user["username"])),
                ],
              ),
            ),
            buildFollowButton(
                controller: controller, uid: user["uid"], user: user),
          ],
        ).paddingSymmetric(horizontal: 12.0, vertical: 6.0),
      ),
    );
  }

  Widget buildButton(
      {required FollowersController controller, required String uid}) {
    if (controller.checkFollow(uid: uid)) {
      return ClayContainer(
        borderRadius: 24.0,
        color: theme.cardColor,
        parentColor: theme.scaffoldBackgroundColor,
        depth: 20,
        spread: 1,
        curveType: CurveType.concave,
        child: ScaleFactorText(
          text: 'Takibi bırak',
          style: theme.textTheme.labelLarge!.medium,
        ).paddingSymmetric(
            horizontal: Get.width * 0.045, vertical: Get.width * 0.015),
      );
    } else {
      return ClayContainer(
        borderRadius: 24.0,
        color: theme.primaryColor,
        parentColor: theme.scaffoldBackgroundColor,
        depth: 20,
        spread: 1,
        curveType: CurveType.concave,
        child: ScaleFactorText(
          text: 'Takip et',
          style: theme.textTheme.labelLarge!.medium,
        ).paddingSymmetric(
            horizontal: Get.width * 0.045, vertical: Get.width * 0.015),
      );
    }
  }

  Widget buildFollowButton(
      {required FollowersController controller,
      required String uid,
      required Map user}) {
    if (!controller.isMyProfile(uid: user["uid"])) {
      return CustomInkWell(
        onTap: () async {
          await controller.setFollow(user: user);
        },
        child: Obx(() => buildButton(controller: controller, uid: uid)),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget buildImage(Map user) {
    return ProfilePhoto(
      url: user["profile_image"],
      imageHeight: 40,
      imageWidth: 40,
      iconSize: 28,
    );
  }

  Widget buildUsername(String username) {
    return ScaleFactorAutoSizeText(
      text: username,
      style: theme.textTheme.bodyMedium!.medium,
      maxLines: 1,
    );
  }
}
