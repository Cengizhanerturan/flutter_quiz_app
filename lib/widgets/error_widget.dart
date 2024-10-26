import 'package:flutter_quiz_app/core/base/base_stateless_widget.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_autosize_text.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomErrorWidget extends BaseStatelessWidget {
  final String message;
  final bool isRetry;
  final dynamic Function()? retryFunction;
  const CustomErrorWidget(
      {Key? key,
      required this.message,
      this.isRetry = false,
      this.retryFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/lottie/error.json',
            fit: BoxFit.contain,
            width: Get.width,
          ).paddingSymmetric(horizontal: Get.width * 0.01),
          SizedBox(
            height: Get.height * 0.05,
          ),
          ScaleFactorText(
            text: message,
            style: theme.textTheme.bodyLarge!.medium
                .copyWith(color: theme.disabledColor),
            textAlign: TextAlign.center,
          ).paddingSymmetric(horizontal: Get.width * 0.01),
          SizedBox(
            height: Get.height * 0.05,
          ),
          _buildRetryButton(),
        ],
      ),
    );
  }

  Widget _buildRetryButton() {
    if (isRetry) {
      return CustomInkWell(
        onTap: () {
          if (retryFunction != null) {
            retryFunction!();
          }
        },
        child: ClayContainer(
          width: Get.width * 0.5,
          borderRadius: 30.0,
          color: theme.primaryColor,
          parentColor: theme.scaffoldBackgroundColor,
          depth: 20,
          spread: 1,
          curveType: CurveType.concave,
          child: ScaleFactorAutoSizeText(
            text: 'Tekrar Dene',
            style: theme.textTheme.bodyMedium!.bold,
            textAlign: TextAlign.center,
            maxLines: 1,
          ).paddingSymmetric(vertical: 16.0),
        ).paddingSymmetric(horizontal: 16.0),
      );
    } else {
      return const SizedBox();
    }
  }
}
