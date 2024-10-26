import 'dart:io';
import 'package:flutter_quiz_app/core/model/notification.dart';
import 'package:flutter_quiz_app/core/service/cache/cache.dart';
import 'package:flutter_quiz_app/core/service/notification/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  debugPrint('Handling a background message ${message?.messageId}');

  try {
    await Firebase.initializeApp();
    if (message == null) return;
    final localNotificationService = LocalNotificationService();
    await localNotificationService.init();
    if (message.data.isNotEmpty) {
      try {
        var notificationModel =
            NotificationModel.fromJson(message.data['content']);
        await localNotificationService
            .showCustomNotification(notificationModel);
      } catch (e) {
        debugPrint('firebase messaging background handler error : $e');
      }
    } else {
      return;
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

class NotificationService extends GetxService {
  final _userController = Get.find<UserController>();
  final _cacheService = Get.find<CacheService>();
  final _localNotificationService = Get.find<LocalNotificationService>();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  var isOpenNotification = true.obs;

  bool get getIsOpenNotification => isOpenNotification.value;

  Future<String?> getToken() async {
    try {
      return await _fcm.getToken();
    } catch (e) {
      debugPrint('getToken Error: $e');
      return null;
    }
  }

  Future<void> init() async {
    var token = await _fcm.getToken();
    debugPrint('token: $token');

    if (Platform.isAndroid) {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    }
    if (!kIsWeb) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('onMessage listen worked...');
      if (Platform.isAndroid) {
        _localNotificationService.addNotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Opened App From Notification Message Click');

      var notification = createNotificationFromMessage(message);
      _localNotificationService.onSelectNotification(notification);
    }).onError((handleError) {
      debugPrint('Error onMessageOpenedApp handle : $handleError');
    });

    initializeChannels();

    _configureDidReceiveLocalNotificationSubject();
    if (Platform.isAndroid) {
      await getInitialMessage();
    }
  }

  Future<void> initializeChannels() async {
    try {
      var condition = await _cacheService.initChannels();
      if (!condition) {
        debugPrint('initialize notification channels');
        await _fcm.subscribeToTopic('HomeNotification');
        if (_userController.userInfo.value != null &&
            _userController.uid.value.isNotEmpty) {
          await _fcm.subscribeToTopic(_userController.uid.value);
        }
        await _cacheService.saveInitChannels();
      } else {
        debugPrint('notification channels already initialized');
      }
    } catch (e) {
      debugPrint('Cache channels error $e');
    }
  }

  Future<void> subscribeChannel({required String topic}) async {
    debugPrint('subscribeChannel: $topic');
    await _fcm.subscribeToTopic(topic);
  }

  Future<void> unsubscribeChannel({required String topic}) async {
    debugPrint('unsubscribeChannel: $topic');
    await _fcm.unsubscribeFromTopic(topic);
  }

  Future<void> allUnsubscribeChannel() async {
    debugPrint('all unsubscribe channel');
    isOpenNotification.value = false;
    await _fcm.unsubscribeFromTopic('HomeNotification');
    await _fcm.unsubscribeFromTopic(_userController.uid.value);
    await setLocalData(false);
  }

  Future<void> allSubscribeChannel() async {
    debugPrint('all subscribe channel');
    isOpenNotification.value = true;
    await _fcm.subscribeToTopic('HomeNotification');
    if (_userController.uid.value.isNotEmpty) {
      await _fcm.subscribeToTopic(_userController.uid.value);
    }
    await setLocalData(true);
  }

  Future<void> logOut() async {
    if (_userController.uid.value.isNotEmpty) {
      await _fcm.unsubscribeFromTopic(_userController.uid.value);
    }
    await _fcm.subscribeToTopic('HomeNotification');
    await setLocalData(true);
  }

  Future<void> getLocalData() async {
    if (_cacheService.box.hasData('isOpenNotification')) {
      isOpenNotification.value = _cacheService.box.read('isOpenNotification');
    } else {
      await setLocalData(true);
      isOpenNotification.value = true;
    }
  }

  Future<void> setLocalData(bool isOpen) async {
    await _cacheService.box.write('isOpenNotification', isOpen);
  }

  Future<void> getInitialMessage() async {
    try {
      await _fcm.getInitialMessage().then((message) async {
        debugPrint('getInitialMessage : $message');
        if (message != null) {
          var notificationModel = createNotificationFromMessage(message);
          _localNotificationService.onSelectNotification(notificationModel);
        }
      });
    } catch (e) {
      debugPrint('getInitialMessage Error : $e');
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    _localNotificationService.didReceiveLocalNotificationSubject.stream.listen(
      (RemoteMessage? message) async {
        debugPrint('notification : ${message?.notification}');
        debugPrint('Data : ${message?.data}');
        await checkNotificationType(message);
      },
    );
  }

  Future<void> checkNotificationType(RemoteMessage? message) async {
    var notification = createNotificationFromMessage(message);
    await _localNotificationService.showCustomNotification(notification);
  }

  NotificationModel? createNotificationFromMessage(RemoteMessage? message) {
    if (message == null) return null;
    NotificationModel? notificationModel;
    if (message.data.isNotEmpty) {
      try {
        notificationModel = NotificationModel.fromJson(message.data['content']);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return notificationModel;
  }
}
