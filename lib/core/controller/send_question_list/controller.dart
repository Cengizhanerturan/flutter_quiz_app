import 'package:flutter_quiz_app/core/model/send_question.dart';
import 'package:flutter_quiz_app/core/service/remote/user/remote.dart';
import 'package:flutter_quiz_app/core/util/helper.dart';
import 'package:get/get.dart';

class SendQuestionListController extends GetxController with StateMixin {
  final _userController = Get.find<UserController>();

  var questionList = <SendQuestionModel>[].obs;

  var isSend = false.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    var response =
        await UserService.getSendQuestionList(uid: _userController.uid.value);
    if (response.status == 'success') {
      List list = response.data!["list"];
      if (list.isEmpty) {
        questionList.value = [];
        change(state, status: RxStatus.empty());
      } else {
        questionList.value = SendQuestionModel.decoder(list);
        change(state, status: RxStatus.success());
      }
    } else {
      change(state, status: RxStatus.error());
    }
  }

  Future<void> onError() async {
    await getData();
  }

  Future<void> cancelQuestion(
      {required int index, required SendQuestionModel model}) async {
    await sendQuestionCancelDialog().then(
      (value) async {
        if (value) {
          var response = await UserService.getCancelQuestion(
              uid: _userController.uid.value, qid: model.qid);
          if (response.status == 'success') {
            model.status = 3;
            model.statusString =
                SendQuestionModel.setStatusString(model.status);
            questionList[index] = model;
            update();
            await Helper.openDialog(
                dialog: CustomDialog(
                    status: response.status, message: response.message!));
          } else {
            await Helper.openDialog(
                dialog: CustomDialog(
                    status: response.status, message: response.message!));
          }
        }
      },
    );
  }
}
