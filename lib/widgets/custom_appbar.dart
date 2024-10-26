import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/widgets/back_button.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onBack;
  const CustomAppBar({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ScaleFactorText(
        text: title,
        style: Get.theme.textTheme.headlineMedium!.semibold,
        textAlign: TextAlign.center,
      ),
      leading: CustomBackButton(func: onBack),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => _PreferredAppBarSize(kToolbarHeight, null);
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
