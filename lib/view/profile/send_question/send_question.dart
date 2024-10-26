import 'package:flutter_quiz_app/core/base/base_get_view.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/widgets/custom_appbar.dart';
import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:flutter_quiz_app/widgets/custom_text_field.dart';
import 'package:flutter_quiz_app/widgets/form_title.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class SendQuestion extends BaseGetView<SendQuestionController> {
  const SendQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: controller.onPopInvokedWithResult,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          title: 'Soru Gönder',
          onBack: () => controller.getBack(),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.height,
              _buildForm(context),
              36.height,
            ],
          ).paddingSymmetric(horizontal: 16.0),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: controller.sendQuestionInfoKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategory(),
          24.height,
          _buildQuestion(),
          24.height,
          _buildAnswer(
              title: 'A Şıkkı',
              hintText: 'A şıkkını giriniz',
              textEditingController: controller.aAnswerController,
              focusNode: controller.aAnswerFocusNode),
          24.height,
          _buildAnswer(
              title: 'B Şıkkı',
              hintText: 'B şıkkını giriniz',
              textEditingController: controller.bAnswerController,
              focusNode: controller.bAnswerFocusNode),
          24.height,
          _buildAnswer(
              title: 'C Şıkkı',
              hintText: 'C şıkkını giriniz',
              textEditingController: controller.cAnswerController,
              focusNode: controller.cAnswerFocusNode),
          24.height,
          _buildAnswer(
              title: 'D Şıkkı',
              hintText: 'D şıkkını giriniz',
              textEditingController: controller.dAnswerController,
              focusNode: controller.dAnswerFocusNode),
          24.height,
          _buildTrueAnswer(),
          36.height,
          _buildSendButton(context),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormTitle(title: 'Kategori'),
        8.height,
        CustomInkWell(
          onTap: () async {},
          child: Obx(
            () => Container(
              width: Get.width,
              padding: getCategoryPadding(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: theme.cardColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScaleFactorText(
                    text: buildCategoryText(),
                    style: buildCategoryTextStyle(),
                  ),
                  buildCategoryIcon(),
                ],
              ),
            ),
          ),
        ),
        bottomSheetValidator(isCategory: true),
      ],
    );
  }

  Widget _buildQuestion() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormTitle(title: 'Soru'),
        8.height,
        CustomTextField(
          textFieldType: TextFieldType.MULTILINE,
          keyboardType: TextInputType.multiline,
          controller: controller.questionController,
          focus: controller.questionFocusNode,
          hintText: 'Soruyu giriniz',
        ),
      ],
    );
  }

  Widget _buildAnswer(
      {required String title,
      required String hintText,
      required TextEditingController textEditingController,
      required FocusNode focusNode}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormTitle(title: title),
        8.height,
        CustomTextField(
          hintText: hintText,
          textFieldType: TextFieldType.MULTILINE,
          keyboardType: TextInputType.multiline,
          controller: textEditingController,
          focus: focusNode,
        ),
      ],
    );
  }

  Widget _buildSendButton(BuildContext context) {
    return CustomInkWell(
      onTap: () {},
      child: ClayContainer(
        width: Get.width,
        borderRadius: 16.0,
        color: theme.primaryColor,
        parentColor: theme.scaffoldBackgroundColor,
        depth: 20,
        spread: 1,
        curveType: CurveType.concave,
        child: ScaleFactorText(
          text: 'Gönder',
          style: theme.textTheme.bodyMedium!.bold,
          textAlign: TextAlign.center,
        ).paddingSymmetric(vertical: 16.0),
      ),
    );
  }
}
