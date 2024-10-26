import 'dart:convert';
import 'package:flutter_quiz_app/core/constants/enums.dart';
import 'package:flutter_quiz_app/core/util/extensions.dart';
import 'package:flutter/material.dart';

class NotificationModel {
  NotificationModel({
    this.type,
    this.route,
    this.title,
    this.body,
    this.followUid,
  });
  final MessageType? type;
  MessageRoute? route;
  final String? title;
  final String? body;
  final String? followUid;

  Map<String, String?> toMap() {
    return {
      'type': type?.typeToString(),
      'route': route?.routeToString(),
      'title': title,
      'body': body,
      'followUid': followUid,
    };
  }

  factory NotificationModel.fromMap(Map<String?, dynamic>? map) {
    if (map == null) throw ArgumentError('Map null error...');
    try {
      return NotificationModel(
        type: map['type'].toString().stringToMessageType,
        route: map['route'].toString().stringToMessageRoute,
        title: map['title'],
        body: map['body'],
        followUid: map['followUid'],
      );
    } catch (e) {
      debugPrint('notification factory error : $e');
      return throw Exception(e);
    }
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String? source) {
    if (source == null) throw ArgumentError('source null error...');
    var content = jsonDecode(source);
    if (content == null || content.isEmpty) {
      throw ArgumentError('content null error...');
    }
    return NotificationModel.fromMap(content);
  }

  @override
  String toString() => toMap().toString();
}
