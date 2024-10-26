import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/core/base/base_stateless_widget.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';

class FormTitle extends BaseStatelessWidget {
  final String title;
  const FormTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ScaleFactorText(
      text: title,
      style: theme.textTheme.titleSmall!.medium,
    );
  }
}
