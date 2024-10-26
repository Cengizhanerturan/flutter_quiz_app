import 'dart:convert';

class AppConstants {
  static const String appName = 'Flutter Quiz App';
  static const String subTitleText = '';
  static const String textFontFamily = 'VisbyCF';

  static Map<String, dynamic> remoteConfigDefault = {
    "urls": jsonEncode({
      "apiBaseUrl": "BASE_URL",
    }),
    "appStatus": jsonEncode({
      "isAppActive": true,
      "appDisableMessage":
          "Şu anda uygulamaya bakım yapılmaktadır. Anlayışınız için teşekkür ederiz."
    }),
  };
}
