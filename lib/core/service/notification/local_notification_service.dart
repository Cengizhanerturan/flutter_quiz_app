import 'package:flutter_quiz_app/core/constants/enums.dart';
import 'package:flutter_quiz_app/core/model/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';

const _channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

class LocalNotificationService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final BehaviorSubject<RemoteMessage> didReceiveLocalNotificationSubject =
      BehaviorSubject<RemoteMessage>();

  Future<void> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
        ) async {
          debugPrint(
              'onDidReceiveLocalNotification : id: $id\ntitle: $title\nbody: $body\npayload: $payload');
        });

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
      if (response.payload != null) {
        var notificationModel = NotificationModel.fromJson(response.payload);
        onSelectNotification(notificationModel);
        debugPrint('notification : $notificationModel');
      }
    });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel)
        .catchError((onError) {
      debugPrint('Local Notification Error : $onError');
    });
  }

  Future<void> didNotificationLaunchApp() async {
    final notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      try {
        var notificationModel = NotificationModel.fromJson(
            notificationAppLaunchDetails?.notificationResponse!.payload);
        // ignore: unawaited_futures
        onSelectNotification(notificationModel);
      } catch (e) {
        debugPrint('@@@@@@@@@ launchAppWithNotification error : $e');
      }
    }
  }

  void onSelectNotification(NotificationModel? notification) async {
    if (notification == null) return;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigationWithNotification(notification);
    });
  }

  void navigationWithNotification(NotificationModel notification) async {
    if (notification.route != null) {
      switch (notification.route) {
        case MessageRoute.home:
          break;
        case MessageRoute.profile:
          if (notification.followUid != null &&
              notification.followUid!.trim() != '') {
            await Get.toProfilePage(uid: notification.followUid!);
          }
          break;
        default:
          debugPrint('Default Notification');
          return;
      }
    }
  }

  Future<void> showCustomNotification(
      NotificationModel? notificationModel) async {
    if (notificationModel == null) return;
    NotificationDetails? notificationDetails;
    try {
      notificationDetails = await _createNotificationDetails(notificationModel);
    } catch (e) {
      debugPrint('create notification details error : $e');
    }
    try {
      String? title = notificationModel.title ?? 'Flutter Quiz App';
      await flutterLocalNotificationsPlugin.show(
        notificationModel.hashCode,
        title,
        notificationModel.body ?? '',
        notificationDetails,
        payload: notificationModel.toJson(),
      );
    } catch (e) {
      debugPrint('showCustomNotification Error: $e');
    }
  }

  Future<NotificationDetails> _createNotificationDetails(
      NotificationModel notification) async {
    // var sounds = _createNotificationSound(notification);
    var iosAttachment = <DarwinNotificationAttachment>[];
    var androidNotificationDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      // largeIcon: _controlLargeIcon(notification),

      importance: Importance.max,
      priority: Priority.max,
      // color: notificationService?.iconColor,
      // sound: sounds['androidSound'],
    );
    var iosNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
      attachments: iosAttachment,
      // sound: sounds['iosSound'],
    );
    var notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    return notificationDetails;
  }

  void addNotification(RemoteMessage message) {
    didReceiveLocalNotificationSubject.add(message);
  }
}
