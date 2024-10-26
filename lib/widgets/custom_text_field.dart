import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/core/base/base_stateless_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomTextField extends BaseStatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focus;
  final String? hintText;
  final TextFieldType textFieldType;
  final TextInputType keyboardType;
  final int? maxLength;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    this.controller,
    this.focus,
    this.hintText,
    this.textFieldType = TextFieldType.NAME,
    this.keyboardType = TextInputType.name,
    this.maxLength,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      validator: validator,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide.none,
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide.none,
        ),
        fillColor: theme.cardColor,
        hintText: hintText,
        hintStyle:
            theme.textTheme.bodyMedium!.copyWith(color: theme.disabledColor),
        filled: true,
      ),
      maxLength: maxLength,
      controller: controller,
      focus: focus,
      textStyle: theme.textTheme.bodyMedium,
      cursorColor: theme.primaryColor,
      textFieldType: textFieldType,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.bottom,
    );
  }
}
