import 'package:get/get.dart';

class AppController extends GetxController {
  //AppConfig
  var isAppActive = true;
  var appDisableMessage =
      'Şu anda uygulamaya bakım yapılmaktadır. Anlayışınız için teşekkür ederiz.';
  var penaltyPoint = 50;
  var heartMaxLimit = 20;

  var playStoreUrl = "";
  var privacyPolicyUrl = "";

  //Profile Images
  var profileImageBaseUrl = '';
  var profileImages = [];
}
