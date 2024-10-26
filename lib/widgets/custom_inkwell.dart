import 'package:flutter_quiz_app/core/base/base_stateless_widget.dart';
import 'package:flutter_quiz_app/core/controller/audio/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomInkWell extends BaseStatelessWidget {
  final _audioController = Get.find<AudioController>();
  final Function onTap;
  final Widget child;
  final bool isClickSound;
  CustomInkWell(
      {super.key,
      required this.onTap,
      required this.child,
      this.isClickSound = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      onTap: () async {
        if (isClickSound) {
          await _audioController.playClickSound();
        }
        onTap();
      },
      child: child,
    );
  }
}
