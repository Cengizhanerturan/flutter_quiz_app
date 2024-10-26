import 'package:flutter_quiz_app/core/controller/send_question_list/controller.dart';
import 'package:get/get.dart';

class SendQuestionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SendQuestionListController());
  }
}
