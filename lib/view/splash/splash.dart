import 'package:flutter_quiz_app/core/constants/app_constants.dart';
import 'package:flutter_quiz_app/core/controller/app/controller.dart';
import 'package:flutter_quiz_app/core/controller/category/controller.dart';
import 'package:flutter_quiz_app/core/service/notification/local_notification_service.dart';
import 'package:flutter_quiz_app/core/service/remote_config/remote_config.dart';
import 'package:flutter_quiz_app/core/service/routes/app_routes.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late final AppController _appController;
  ThemeData get theme => Get.theme;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await startService();
    if (_appController.isAppActive) {
      if (mounted) nb.finish(context);
    } else {
      if (mounted) nb.finish(context);
      Get.offNamed(Routes.unservice);
    }
  }

  Future<void> startService() async {
    _appController = Get.put(AppController(), permanent: true);
    await Get.putAsync<RemoteConfigService>(RemoteConfigService().init);
    Get.put(LocalNotificationService(), permanent: true);
    Get.put(CategoryController(), permanent: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          Container(
            child: ScaleFactorText(
              text: AppConstants.appName,
              style: theme.textTheme.bodyMedium,
            ).center(),
          ),
          Expanded(
            child: SizedBox(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator(
                  color: theme.primaryColor,
                ).paddingBottom(16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
