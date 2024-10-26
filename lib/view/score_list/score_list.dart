import 'package:flutter_quiz_app/core/base/base_get_view.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/core/controller/score_list/controller.dart';
import 'package:flutter_quiz_app/core/service/routes/app_routes.dart';
import 'package:flutter_quiz_app/widgets/custom_appbar.dart';
import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:flutter_quiz_app/widgets/profile_photo.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_autosize_text.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:numeral/numeral.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ScoreList extends BaseGetView<ScoreListController> {
  const ScoreList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: controller.onPopInvokedWithResult,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Sıralama',
          onBack: () {
            controller.pageCurrentIndex.value = 0;
            controller.refreshControllerSetIdle();
            Get.offNamed(Routes.home);
          },
        ),
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            _buildTabbarArea(),
            16.height,
            _buildTabbarView(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabbarView() {
    return Expanded(
      child: PageView(
        controller: controller.pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) {
          controller.pageCurrentIndex.value = index;
        },
        children: [
          _buildTabbarBody(
            type: 'daily',
            list: controller.dailyScoreList,
            userRank: _userController.dailyUserRank.value.toString(),
            userScore: _userController.dailyScore.value.toString(),
          ),
          _buildTabbarBody(
            type: 'monthly',
            list: controller.monthlyScoreList,
            userRank: _userController.monthlyUserRank.value.toString(),
            userScore: _userController.monthlyScore.value.toString(),
          ),
          _buildTabbarBody(
            type: 'allTime',
            list: controller.allTimeScoreList,
            userRank: _userController.allTimeUserRank.value.toString(),
            userScore: _userController.allTimeScore.value.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabbarArea() {
    return ClayContainer(
      width: Get.width,
      height: 42,
      borderRadius: 30.0,
      color: theme.cardColor,
      parentColor: theme.scaffoldBackgroundColor,
      depth: 10,
      spread: 1,
      curveType: CurveType.concave,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildTabbar("Günlük", 0, () {}),
          _buildTabbar("Aylık", 1, () {}),
          _buildTabbar("Tümü", 2, () {}),
        ],
      ).paddingAll(3.0),
    ).paddingSymmetric(horizontal: 16.0);
  }

  Widget _buildTabbar(String title, int index, Function() onTap) {
    return Expanded(
      child: CustomInkWell(
        onTap: () => onTap(),
        child: Container(
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: controller.getTabBarColor(index: index),
          ),
          child: Align(
            alignment: Alignment.center,
            child: ScaleFactorText(
              text: title,
              style: theme.textTheme.titleSmall!.medium,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabbarBody(
      {required String type,
      required List list,
      required String userRank,
      required String userScore}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getPodiumUser(list: list, rank: 2, size: 80, iconSize: 46),
            16.width,
            getPodiumUser(list: list, rank: 1, size: 100, iconSize: 60),
            16.width,
            getPodiumUser(list: list, rank: 3, size: 80, iconSize: 46),
          ],
        ),
        24.height,
        getDivider(),
        _buildList(type, list),
      ],
    );
  }

  Widget _buildList(String type, List<dynamic> list) {
    return Expanded(
      child: SmartRefresher(
        cacheExtent: 0,
        controller: controller.getRefreshController(type: type),
        physics: const BouncingScrollPhysics(),
        enablePullDown: false,
        enableTwoLevel: true,
        enablePullUp: true,
        onLoading: () => controller.loadMore(type: type, offset: list.length),
        header: CustomHeader(
            builder: ((BuildContext context, RefreshStatus? refreshStatus) =>
                const SizedBox())),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? loadStatus) =>
              controller.loadMoreWidgetBuilder(loadStatus: loadStatus),
        ),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: list.length - 3,
          itemBuilder: (BuildContext context, int index) {
            var user = list[index + 3];
            return Column(
              children: [
                if (index == 0) 24.height,
                _buildCard(user),
                12.height,
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(user) {
    return CustomInkWell(
      onTap: () => controller.toProfilePage(uid: user.uid),
      child: ClayContainer(
        width: Get.width,
        height: controller.getStarHeightWidget(
            myUid: _userController.uid.value, thisUid: user.uid),
        borderRadius: 16.0,
        color: theme.cardColor,
        parentColor: theme.scaffoldBackgroundColor,
        depth: 10,
        spread: 1,
        curveType: CurveType.concave,
        child: Row(
          children: [
            _buildUserRank(user),
            Expanded(
              child: Container(
                height: Get.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildProfilePhoto(user),
                        8.width,
                        _buildUsername(user),
                      ],
                    ),
                    _buildScore(user),
                  ],
                ).paddingOnly(left: 8.0, right: 12.0, top: 6.0, bottom: 6.0),
              ),
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: 16.0),
    );
  }

  Widget _buildProfilePhoto(user) {
    return ProfilePhoto(
      url: user.profileImage,
      imageHeight: 40,
      imageWidth: 40,
      iconSize: 28,
    );
  }

  Widget _buildUsername(user) {
    return ScaleFactorText(
      text: user.username,
      style: theme.textTheme.bodyMedium!.medium,
    );
  }

  Widget _buildScore(user) {
    return ScaleFactorText(
      text: numeral(user.score),
      style: theme.textTheme.bodyMedium!.semibold,
    );
  }

  Widget _buildUserRank(user) {
    return Container(
      width: 60,
      height: Get.height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
        ),
        color: theme.primaryColor,
      ),
      child: Align(
        alignment: Alignment.center,
        child: ScaleFactorAutoSizeText(
          text: user.userRank.toString(),
          style: theme.textTheme.titleSmall!.bold,
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ).paddingSymmetric(horizontal: 4.0),
    );
  }

  Widget getDivider() {
    return Container(
      width: Get.width,
      height: 1,
      color: theme.cardColor,
    );
  }

  Widget getPodiumUser(
      {required List list,
      required int rank,
      required double size,
      required double iconSize}) {
    return CustomInkWell(
      onTap: () => controller.toProfilePage(uid: list[rank - 1].uid),
      child: Column(
        children: [
          if (rank != 1) 64.height,
          Stack(
            children: [
              ProfilePhoto(
                url: list[rank - 1].profileImage,
                imageHeight: size,
                imageWidth: size,
                iconSize: iconSize,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.primaryColor,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: ScaleFactorText(
                      text: rank.toString(),
                      style: theme.textTheme.titleSmall!.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          6.height,
          ScaleFactorText(
            text: list[rank - 1].username,
            style: theme.textTheme.titleSmall!.medium,
          ),
          6.height,
          ScaleFactorText(
            text: numeral(list[rank - 1].score),
            style: theme.textTheme.bodySmall!.medium,
          ),
        ],
      ),
    );
  }
}
