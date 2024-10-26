import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CacheService extends GetxService {
  var box = GetStorage();

  Future<bool> initChannels() async {
    try {
      if (box.hasData('isInitializeChannels')) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> saveInitChannels() async {
    try {
      await box.write('isInitializeChannels', true);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
