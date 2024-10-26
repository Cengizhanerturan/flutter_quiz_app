import 'package:flutter_quiz_app/core/model/all_time_score_list.dart';
import 'package:flutter_quiz_app/core/model/daily_score_list.dart';
import 'package:flutter_quiz_app/core/model/monthly_score_list.dart';
import 'package:flutter_quiz_app/core/service/remote/score_list/remote.dart';
import 'package:flutter_quiz_app/core/service/routes/app_routes.dart';
import 'package:flutter_quiz_app/core/util/get_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ScoreListController extends GetxController {
  PageController pageController = PageController();
  var pageCurrentIndex = 0.obs;

  var allTimeScoreList = <AllTimeScoreListModel>[].obs;
  var monthlyScoreList = <MonthlyScoreListModel>[].obs;
  var dailyScoreList = <DailyScoreListModel>[].obs;

  var isLoading = false.obs;

  final refreshControllers = <RefreshController>[
    RefreshController(),
    RefreshController(),
    RefreshController()
  ];

  @override
  void onInit() {
    super.onInit();
    getScoreList();
  }

  Future<void> getScoreList() async {
    isLoading.value = true;
    await ScoreListService.getDailyScoreList(offset: '0');
    await ScoreListService.getMonthlyScoreList(offset: '0');
    await ScoreListService.getAllTimeScoreList(offset: '0');
    isLoading.value = false;
  }

  void refreshControllerSetIdle() {
    refreshControllers[0].footerMode!.value = LoadStatus.idle;
    refreshControllers[1].footerMode!.value = LoadStatus.idle;
    refreshControllers[2].footerMode!.value = LoadStatus.idle;
  }

  Future<bool> loadMore({required String type, required int offset}) async {}

  Future<void> toProfilePage({required String uid}) async {
    if (_userController.uid.value != uid) {
      await Get.toProfilePage(uid: uid);
    }
  }

  RefreshController getRefreshController({required String type}) {
    if (type == 'daily') {
      return refreshControllers[0];
    } else if (type == 'monthly') {
      return refreshControllers[1];
    } else {
      return refreshControllers[2];
    }
  }

  void animateToPage({required int index}) {
    pageController.jumpToPage(index);
  }

  bool getUidControl({required String myUid, required String thisUid}) {
    return myUid == thisUid;
  }

  double getStarHeightWidget({required String myUid, required String thisUid}) {
    var check = getUidControl(myUid: myUid, thisUid: thisUid);
    if (check) {
      return 56;
    } else {
      return 50;
    }
  }

  Future<void> onPopInvokedWithResult(bool didPop, Object? result) async {
    pageCurrentIndex.value = 0;
    refreshControllerSetIdle();
    Get.offNamed(Routes.home);
  }
}
