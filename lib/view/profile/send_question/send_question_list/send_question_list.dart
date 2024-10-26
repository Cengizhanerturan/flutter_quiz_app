import 'package:flutter_quiz_app/core/base/base_get_view.dart';
import 'package:flutter_quiz_app/core/config/theme/app_colors.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/core/constants/assets_constants.dart';
import 'package:flutter_quiz_app/core/constants/string_constants.dart';
import 'package:flutter_quiz_app/core/controller/send_question_list/controller.dart';
import 'package:flutter_quiz_app/core/model/send_question.dart';
import 'package:flutter_quiz_app/widgets/custom_appbar.dart';
import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:flutter_quiz_app/widgets/empty_widget.dart';
import 'package:flutter_quiz_app/widgets/error_widget.dart';
import 'package:flutter_quiz_app/widgets/loading.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class SendQuestionList extends BaseGetView<SendQuestionListController> {
  const SendQuestionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Gönderilen Sorular'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sendButton(),
            8.height,
            GetBuilder<SendQuestionListController>(
              builder: (controller) => controller.obx(
                (state) => _buildList(),
                onLoading: const Expanded(
                  child: LoadingWidget(),
                ),
                onEmpty: const CustomEmptyWidget(
                    message: 'Daha önce gönderilmiş sorunuz bulunmamaktadır'),
                onError: (error) => CustomErrorWidget(
                  message: StringConstants.errorText,
                  isRetry: true,
                  retryFunction: () => controller.onError(),
                ),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.0),
      ),
    );
  }

  Widget _sendButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: CustomInkWell(
        onTap: () {},
        child: ClayContainer(
          borderRadius: 24.0,
          color: theme.primaryColor,
          parentColor: theme.scaffoldBackgroundColor,
          depth: 20,
          spread: 1,
          curveType: CurveType.concave,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ImageIcon(
                AssetImage(AssetsConstants.sendQuestionIcon),
                size: 24.0,
                color: AppColors.primaryWhiteColor,
              ),
              8.width,
              ScaleFactorText(
                text: 'Soru Gönder',
                style: theme.textTheme.bodySmall!.semibold,
              ),
            ],
          ).paddingOnly(left: 12.0, right: 24.0, top: 8.0, bottom: 8.0),
        ),
      ),
    );
  }

  Widget _buildList() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: controller.questionList.length,
        itemBuilder: (BuildContext context, int index) {
          var model = controller.questionList[index];
          return Column(
            children: [
              const SizedBox(
                height: 8.0,
              ),
              buildQuestionCard(index: index, model: model),
              const SizedBox(
                height: 8.0,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildQuestionCard(
      {required int index, required SendQuestionModel model}) {
    return ClayContainer(
      width: Get.width,
      borderRadius: 16.0,
      color: theme.cardColor,
      parentColor: theme.scaffoldBackgroundColor,
      depth: 10,
      spread: 1,
      curveType: CurveType.none,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategory(model),
              buildPopupBtn(index: index, model: model),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuestion(model),
              12.height,
              _buildRichText("A)", model.a),
              6.height,
              _buildRichText("B)", model.b),
              6.height,
              _buildRichText("C)", model.c),
              6.height,
              _buildRichText("D)", model.d),
              12.height,
              _buildRichText("Cevap: ", model.answer),
            ],
          ).paddingAll(12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTime(model),
              _buildStatus(model),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategory(SendQuestionModel model) {
    return ClayContainer(
      customBorderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12.0),
        bottomRight: Radius.circular(12.0),
      ),
      color: theme.cardColor,
      parentColor: theme.scaffoldBackgroundColor,
      depth: 16,
      spread: 1,
      curveType: CurveType.convex,
      child: ScaleFactorText(
        text: toCamelcase(text: model.categoryName),
        style: theme.textTheme.bodySmall!.medium,
      ).paddingSymmetric(horizontal: 12.0, vertical: 8.0),
    );
  }

  Widget _buildRichText(String key, String text) {
    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodyMedium!.regular,
        children: [
          TextSpan(
            text: '$key ',
            style: theme.textTheme.bodyMedium!.semibold,
          ),
          TextSpan(
            text: text,
            style: theme.textTheme.bodyMedium!.regular,
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(SendQuestionModel model) {
    return ScaleFactorText(
      text: model.question,
      style: theme.textTheme.bodyMedium!.semibold,
    );
  }
}
