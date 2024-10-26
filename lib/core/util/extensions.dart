import 'package:flutter_quiz_app/core/constants/enums.dart';
import 'package:flutter_quiz_app/core/constants/string_constants.dart';

extension PlayCompleteStatusExtension on int {
  PlayCompleteStatus get getPlayCompleteStatus {
    switch (this) {
      case > 7:
        return PlayCompleteStatus.success;
      case > 4:
        return PlayCompleteStatus.normal;
      default:
        return PlayCompleteStatus.bad;
    }
  }

  String get playCompleteStatusString {
    switch (this) {
      case > 7:
        return StringConstants.playCompleteSuccessText;
      case > 4:
        return StringConstants.playCompleteNormalText;
      default:
        return StringConstants.playCompleteBadText;
    }
  }
}

extension MessageTypeStringExtension on String {
  MessageType get stringToMessageType {
    switch (this) {
      case 'default':
        return MessageType.defaultMessage;
      case 'follow':
        return MessageType.followMessage;
      default:
        return MessageType.defaultMessage;
    }
  }
}

extension MessageRouteStringExtension on String {
  MessageRoute get stringToMessageRoute {
    switch (this) {
      case 'home':
        return MessageRoute.home;
      case 'profile':
        return MessageRoute.profile;
      default:
        return MessageRoute.home;
    }
  }
}

extension MessageTypeExtension on MessageType {
  MessageType operator [](String str) {
    switch (str) {
      case 'default':
        return MessageType.defaultMessage;
      case 'follow':
        return MessageType.followMessage;
      default:
        return MessageType.defaultMessage;
    }
  }

  String typeToString() {
    switch (this) {
      case MessageType.defaultMessage:
        return 'default';
      case MessageType.followMessage:
        return 'follow';
      default:
        return 'default';
    }
  }
}

extension MessageRouteExtension on MessageRoute {
  MessageRoute operator [](String str) {
    switch (str) {
      case 'home':
        return MessageRoute.home;
      case 'profile':
        return MessageRoute.profile;
      default:
        return MessageRoute.home;
    }
  }

  String routeToString() {
    switch (this) {
      case MessageRoute.home:
        return 'home';
      case MessageRoute.profile:
        return 'profile';
      default:
        return 'home';
    }
  }
}
