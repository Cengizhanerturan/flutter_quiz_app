import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseGetView<T> extends GetView<T> {
  const BaseGetView({Key? key}) : super(key: key);

  ThemeData get theme => Get.theme;
}
