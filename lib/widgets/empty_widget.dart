import 'package:flutter_quiz_app/core/base/base_stateless_widget.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomEmptyWidget extends BaseStatelessWidget {
  final String message;
  const CustomEmptyWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/lottie/empty.json',
            fit: BoxFit.contain,
            width: Get.width,
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          ScaleFactorText(
            text: message,
            style: theme.textTheme.bodyLarge!.medium
                .copyWith(color: theme.disabledColor),
            textAlign: TextAlign.center,
          ).paddingSymmetric(horizontal: Get.width * 0.01),
        ],
      ),
    );
  }
}
