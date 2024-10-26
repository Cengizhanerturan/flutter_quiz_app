import 'package:flutter_quiz_app/core/constants/string_constants.dart';
import 'package:flutter_quiz_app/core/model/feedback_category.dart';
import 'package:flutter_quiz_app/core/service/remote/settings/feedback/remote.dart';
import 'package:flutter_quiz_app/core/util/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController with StateMixin {
  var isLoading = false.obs;

  var feedbackCategoryList = <FeedbackCategoryModel>[].obs;
  var selectedFeedbackCategory = Rxn<FeedbackCategoryModel?>();

  final sendFeedbackKey = GlobalKey<FormState>();

  TextEditingController descriptionController = TextEditingController();
  FocusNode descriptionFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    try {
      change(state, status: RxStatus.loading());
      await getFeedbackCategory();
    } catch (e) {
      change(state, status: RxStatus.error());
    }
  }

  Future<void> getFeedbackCategory() async {
    var response = await FeedbackService.getFeedbackCategory();
    if (response.status == 'success') {
      if (response.data != null) {
        feedbackCategoryList.value = response.data;
        change(state, status: RxStatus.success());
      } else {
        change(state, status: RxStatus.error());
      }
    } else {
      change(state, status: RxStatus.error());
    }
  }

  Future<void> onError() async {
    await init();
  }

  Future<void> sendFeedback() async {
    try {
      isLoading.value = true;
      if (selectedFeedbackCategory.value != null &&
          descriptionController.text.isNotEmpty) {
        var responseModel = await FeedbackService.sendFeedback(
            uid: _userController.uid.value,
            fcid: selectedFeedbackCategory.value!.fcid,
            fcName: selectedFeedbackCategory.value!.name,
            content: descriptionController.text);
        if (responseModel.status == 'success') {
          onClear();
          await Helper.openDialog(
              dialog: CustomDialog(
                  status: responseModel.status,
                  message: responseModel.message!));
        } else {
          await Helper.openDialog(
              dialog: CustomDialog(
                  status: responseModel.status,
                  message: responseModel.message!));
        }
      }
    } catch (e) {
      await Helper.openDialog(
          dialog: const CustomDialog(
              status: 'error', message: StringConstants.errorText));
    } finally {
      isLoading.value = false;
    }
  }

  void onClear() {
    isLoading.value = false;
    selectedFeedbackCategory.value = null;
    descriptionController.clear();
    sendFeedbackKey.currentState!.validate();
  }
}
