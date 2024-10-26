import 'dart:convert';
import 'package:flutter_quiz_app/core/constants/api_constants.dart';
import 'package:flutter_quiz_app/core/constants/app_constants.dart';
import 'package:flutter_quiz_app/core/controller/app/controller.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

class RemoteConfigService extends GetxService {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  final _appController = Get.find<AppController>();

  Future<RemoteConfigService> init() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 1),
    ));
    await remoteConfig.setDefaults(AppConstants.remoteConfigDefault);
    await remoteConfig.fetchAndActivate();
    var remoteValues = remoteConfig.getAll();
    if (remoteValues['urls'] != null) {
      var urls = jsonDecode(remoteValues['urls']!.asString());
      ApiConstants.baseURL = urls['apiBaseUrl'];
    }
    if (remoteValues['appStatus'] != null) {
      var appStatus = jsonDecode(remoteValues['appStatus']!.asString());
      _appController.isAppActive = appStatus['isAppActive'];
      _appController.appDisableMessage = appStatus['appDisableMessage'];
    }
    return this;
  }
}
