import 'package:flutter_quiz_app/core/base/base_get_view.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/core/controller/pin_code/controller.dart';
import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class PinCode extends BaseGetView<PinCodeController> {
  const PinCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: controller.canBack.value,
      onPopInvokedWithResult: controller.onPopInvokedWithResult,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
            child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildCountDownTimer(),
                      _buildResendButton(),
                    ],
                  ),
                  36.height,
                  ScaleFactorText(
                    text:
                        'Mail adresinize gönderilen kodu aşağıda bulunan ilgili alana giriniz',
                    style: theme.textTheme.bodyMedium!.medium,
                    textAlign: TextAlign.center,
                  ),
                  12.height,
                  ScaleFactorText(
                    text: '"Spam" klasörünü kontrol etmeyi unutmayın',
                    style: theme.textTheme.bodyMedium!.medium
                        .copyWith(color: theme.disabledColor),
                    textAlign: TextAlign.center,
                  ),
                  36.height,
                  _buildForm(context),
                  36.height,
                  _buildButton(),
                  16.height,
                ],
              ).paddingSymmetric(horizontal: 16.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return CustomInkWell(
      onTap: () async {},
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

  Widget _buildForm(BuildContext context) {
    return Form(
      key: codeKey,
      child: PinCodeTextField(
        appContext: context,
        validator: (value) {
          if (value.toString().isEmpty) {
            return 'Boş bırakılamaz';
          } else if (value.toString().trim().length < 6) {
            return 'En az 6 karakter içermelidir';
          } else {
            return null;
          }
        },
        pastedTextStyle: theme.textTheme.bodyMedium!.medium,
        textStyle: theme.textTheme.bodyMedium!.medium,
        length: 6,
        onChanged: (value) {
          codeKey.currentState!.validate();
          controller.pinCode.value = value.toString();
        },
        enableActiveFill: true,
        cursorColor: theme.primaryColor,
        obscureText: false,
        animationType: AnimationType.fade,
        animationDuration: const Duration(milliseconds: 300),
        pinTheme: PinTheme(
          activeColor: theme.cardColor,
          disabledColor: theme.cardColor,
          inactiveColor: theme.cardColor,
          selectedColor: theme.primaryColor,
          errorBorderColor: theme.cardColor,
          shape: PinCodeFieldShape.box,
          fieldHeight: 50,
          fieldWidth: 40,
          borderRadius: BorderRadius.circular(5),
          activeFillColor: theme.cardColor,
          inactiveFillColor: theme.cardColor,
          selectedFillColor: theme.cardColor,
        ),
      ),
    );
  }

  Widget _buildResendButton() {
    return CustomInkWell(
      onTap: () {},
      child: Container(
        child: ScaleFactorText(
          text: 'Kodu tekrar gönder',
          style: controller.reSendCode.value
              ? theme.textTheme.bodyMedium!.regular
              : theme.textTheme.bodyMedium!.regular
                  .copyWith(color: theme.disabledColor),
        ).paddingOnly(top: 6, bottom: 6, left: 8),
      ),
    );
  }

  Widget _buildCountDownTimer() {
    return CircularCountDownTimer(
      duration: 120,
      initialDuration: 0,
      controller: controller.countdownController,
      width: 34,
      height: 34,
      ringColor: theme.cardColor,
      ringGradient: null,
      fillColor: theme.primaryColor,
      fillGradient: null,
      backgroundColor: theme.scaffoldBackgroundColor,
      backgroundGradient: null,
      strokeWidth: 4.0,
      strokeCap: StrokeCap.round,
      textStyle: theme.textTheme.bodyMedium,
      textFormat: CountdownTextFormat.SS,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {
        controller.reSendCode.value = false;
      },
      onComplete: () {
        controller.reSendCode.value = true;
      },
    );
  }
}
