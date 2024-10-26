import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackButton extends StatelessWidget {
  final Function()? func;
  const CustomBackButton({super.key, this.func});

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () => func != null ? func!() : Get.back(),
      child: ClayContainer(
        color: Get.theme.scaffoldBackgroundColor,
        parentColor: Get.theme.cardColor,
        borderRadius: 75,
        depth: 40,
        spread: 2,
        curveType: CurveType.concave,
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Get.theme.primaryColorLight,
          size: 18,
        ).paddingAll(8.0),
      ),
    );
  }
}
