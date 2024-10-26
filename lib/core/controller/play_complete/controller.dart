import 'package:flutter_quiz_app/core/constants/enums.dart';
import 'package:flutter_quiz_app/core/controller/category/controller.dart';
import 'package:flutter_quiz_app/core/model/category.dart';
import 'package:flutter_quiz_app/core/service/routes/app_routes.dart';
import 'package:confetti/confetti.dart';
import 'package:get/get.dart';

class PlayCompleteController extends GetxController {
  final String tag;
  PlayCompleteController({required this.tag});

  final _categoryController = Get.find<CategoryController>();
  final _questionController = Get.find<QuestionController>();

  final confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  @override
  void onInit() {
    super.onInit();
    playConfetti();
  }

  @override
  void onClose() {
    confettiController.dispose();
    super.onClose();
  }

  void playConfetti() {
    var playCompleteStatus =
        _questionController.questionTrueCount.value.getPlayCompleteStatus;
    if (playCompleteStatus == PlayCompleteStatus.success) {
      confettiController.play();
    }
  }

  CategoryModel? getSelectedCategory() {
    return _categoryController.selectedCategory.value;
  }

  bool getCompleteIsLoading() {
    return _questionController.completeIsLoading.value;
  }

  void setCompleteIsLoading(bool val) {
    _questionController.completeIsLoading.value = val;
  }

  void onClear() {
    _questionController.questionTrueCount.value = 0;
    _questionController.questionFalseCount.value = 0;
    _questionController.questionEmptyCount.value = 0;
  }

  Future<void> onPopInvokedWithResult(
      bool didPop, Object? result, String controllerTag) async {
    onClear();
    Get.delete<PlayCompleteController>(tag: controllerTag);
    Get.toNamed(Routes.home);
  }
}
