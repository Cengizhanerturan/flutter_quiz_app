import 'package:flutter_quiz_app/core/controller/score_list/controller.dart';
import 'package:get/get.dart';

class ScoreListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ScoreListController());
  }
}
