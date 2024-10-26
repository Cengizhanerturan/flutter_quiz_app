import 'package:flutter_quiz_app/core/model/send_question.dart';
import 'package:get/get.dart';

class SendQuestionBinding extends Bindings {
  final bool isEdit;
  final SendQuestionModel? sendQuestionModel;

  SendQuestionBinding({required this.isEdit, this.sendQuestionModel});

  @override
  void dependencies() {
    Get.put(SendQuestionController(
        isEdit: isEdit, sendQuestionModel: sendQuestionModel));
  }
}
