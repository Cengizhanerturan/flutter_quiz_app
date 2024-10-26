import 'package:flutter_quiz_app/core/base/base_stateless_widget.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/core/constants/app_constants.dart';
import 'package:flutter_quiz_app/core/constants/enums.dart';
import 'package:flutter_quiz_app/core/service/remote/register/remote.dart';
import 'package:flutter_quiz_app/core/util/helper.dart';
import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:flutter_quiz_app/widgets/custom_text_field.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class Register extends BaseStatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          64.height,
          ScaleFactorText(
            text: AppConstants.appName,
            style: theme.textTheme.headlineMedium!.medium,
          ),
          24.height,
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildForm(),
                  16.height,
                  _buildRegisterButton(),
                  16.height,
                  ScaleFactorText(
                    text: 'Hesabın var mı?',
                    style: theme.textTheme.bodyMedium,
                  ),
                  2.height,
                  _buildLoginButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return CustomInkWell(
      onTap: () {
        Get.back();
      },
      child: ScaleFactorText(
        text: 'Giriş yap',
        style: theme.textTheme.bodyMedium!.medium
            .copyWith(color: theme.primaryColor),
      ),
    );
  }

  Widget _buildRegisterButton() {
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
          text: 'Kayıt Ol',
          style: theme.textTheme.bodyMedium!.bold,
          textAlign: TextAlign.center,
        ).paddingSymmetric(vertical: 16.0),
      ).paddingSymmetric(horizontal: 16.0),
    );
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          32.height,
          CustomTextField(
            focus: usernameFocusNode,
            controller: usernameController,
            hintText: 'Kullanıcı adı',
            textFieldType: TextFieldType.NAME,
            keyboardType: TextInputType.name,
          ),
          24.height,
          CustomTextField(
            focus: emailFocusNode,
            controller: emailController,
            hintText: 'Email',
            textFieldType: TextFieldType.EMAIL,
            keyboardType: TextInputType.emailAddress,
          ),
          24.height,
          CustomTextField(
            focus: passwordFocusNode,
            controller: passwordController,
            hintText: 'Şifre',
            textFieldType: TextFieldType.PASSWORD,
            keyboardType: TextInputType.visiblePassword,
          ),
          16.height,
        ],
      ).paddingSymmetric(horizontal: 16.0),
    );
  }
}
