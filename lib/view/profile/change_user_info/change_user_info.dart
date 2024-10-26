import 'package:flutter_quiz_app/core/base/base_get_view.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/core/controller/change_user_info/controller.dart';
import 'package:flutter_quiz_app/widgets/custom_appbar.dart';
import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:flutter_quiz_app/widgets/custom_text_field.dart';
import 'package:flutter_quiz_app/widgets/form_title.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ChangeUserInfo extends BaseGetView<ChangeUserInfoController> {
  const ChangeUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: controller.onPopInvokedWithResult,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Bilgileri Değiştir',
          onBack: () {
            controller.getBack();
          },
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
              _buildForm(),
              36.height,
              _buildButton(context),
            ],
          ).paddingSymmetric(horizontal: 16.0),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: controller.changeUserInfoKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormTitle(title: 'isim'),
          8.height,
          CustomTextField(
            controller: controller.nameController,
            focus: controller.nameFocusNode,
            hintText: 'İsim',
          ),
          24.height,
          const FormTitle(title: 'Soyisim'),
          8.height,
          CustomTextField(
            controller: controller.surnameController,
            focus: controller.surnameFocusNode,
            hintText: 'Soyisim',
          ),
          24.height,
          const FormTitle(title: 'Hakkımda'),
          8.height,
          CustomTextField(
            controller: controller.bioController,
            focus: controller.bioFocusNode,
            hintText: 'Hakkımda',
            textFieldType: TextFieldType.MULTILINE,
            keyboardType: TextInputType.multiline,
            maxLength: 120,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return CustomInkWell(
      onTap: () async {
        FocusScope.of(context).unfocus();
        await controller.setUserInfo();
      },
      child: ClayContainer(
        width: Get.width,
        borderRadius: 16.0,
        color: theme.primaryColor,
        parentColor: theme.scaffoldBackgroundColor,
        depth: 20,
        spread: 1,
        curveType: CurveType.concave,
        child: ScaleFactorText(
          text: 'Onayla',
          style: theme.textTheme.bodyMedium!.bold,
          textAlign: TextAlign.center,
        ).paddingSymmetric(vertical: 16.0),
      ),
    );
  }
}
