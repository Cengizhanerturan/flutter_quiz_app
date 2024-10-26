import 'package:flutter_quiz_app/core/base/base_get_view.dart';
import 'package:flutter_quiz_app/core/config/theme/app_colors.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/core/controller/settings/controller.dart';
import 'package:flutter_quiz_app/core/service/routes/app_routes.dart';
import 'package:flutter_quiz_app/widgets/custom_appbar.dart';
import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class Settings extends BaseGetView<SettingsController> {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ayarlar'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: _buildColumn(),
        ),
      ),
    );
  }

  Widget _buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        _buildTitle(title: 'Uygulama Ayarları'),
        12.height,
        _buildSoundSwitch(),
        12.height,
        _buildNotificationSwitch(),
        32.height,
        _buildTitle(title: 'Hesap Ayarları'),
        12.height,
        _buildCard(
          title: 'Email değiştir',
          icon: Icons.mail_outline_rounded,
          onTapFunc: () => Get.toNamed(Routes.changeEmail),
        ),
        12.height,
        _buildCard(
          title: 'Kullanıcı adı değiştir',
          icon: Icons.person_outline_rounded,
          onTapFunc: () => Get.toNamed(Routes.changeUsername),
        ),
        12.height,
        _buildCard(
          title: 'Şifre değiştir',
          icon: Icons.lock_outline_rounded,
          onTapFunc: () => Get.toNamed(Routes.changePassword),
        ),
        12.height,
        _buildCard(
          title: 'Hesap sil',
          icon: Icons.person_remove_outlined,
          onTapFunc: () async => await controller.disableUser(),
        ),
        12.height,
        _buildCard(
          title: 'Çıkış yap',
          icon: Icons.power_settings_new_rounded,
          onTapFunc: () async => await controller.logOut(),
        ),
        32.height,
        _buildTitle(title: 'Genel Bilgiler'),
        12.height,
        _buildCard(
          title: 'Sorun bildir / Destek talebi',
          icon: Icons.support_agent_rounded,
          onTapFunc: () => Get.toNamed(Routes.feedback),
        ),
        12.height,
        _buildCard(
          title: 'KVKK / Gizlilik',
          icon: Icons.security_rounded,
          onTapFunc: () async => await controller.openPrivacyPolicyUrl(),
        ),
        32.height,
      ],
    ).paddingSymmetric(horizontal: 16.0);
  }

  Widget _buildTitle({required String title}) {
    return ScaleFactorText(
      text: title,
      style: theme.textTheme.titleSmall!.medium,
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    void Function()? onTapFunc,
  }) {
    return CustomInkWell(
      onTap: () {
        if (onTapFunc != null) {
          onTapFunc();
        }
      },
      child: ClayContainer(
        width: Get.width,
        borderRadius: 16.0,
        color: theme.cardColor,
        parentColor: theme.scaffoldBackgroundColor,
        depth: 10,
        spread: 1,
        curveType: CurveType.concave,
        child: Row(
          children: [
            ClayContainer(
              color: theme.cardColor,
              parentColor: theme.scaffoldBackgroundColor,
              borderRadius: 75,
              depth: 40,
              spread: 2,
              curveType: CurveType.concave,
              child: Icon(
                icon,
                size: 20.0,
                color: theme.primaryColor,
              ).paddingAll(8.0),
            ),
            12.width,
            ScaleFactorText(
              text: title,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ).paddingSymmetric(horizontal: 12.0, vertical: 8.0),
      ),
    );
  }

  Widget _buildSwitchCard({
    required String title,
    required IconData icon,
    required bool value,
    required void Function(bool value) onChanged,
  }) {
    return ClayContainer(
      width: Get.width,
      borderRadius: 16.0,
      color: theme.cardColor,
      parentColor: theme.scaffoldBackgroundColor,
      depth: 10,
      spread: 1,
      curveType: CurveType.concave,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClayContainer(
                color: theme.cardColor,
                parentColor: theme.scaffoldBackgroundColor,
                borderRadius: 75,
                depth: 40,
                spread: 2,
                curveType: CurveType.concave,
                child: Icon(
                  icon,
                  size: 20.0,
                  color: theme.primaryColor,
                ).paddingAll(8.0),
              ),
              12.width,
              ScaleFactorText(
                text: title,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          Switch(
            value: value,
            activeColor: theme.primaryColor,
            inactiveThumbColor: AppColors.primaryColor.withOpacity(.4),
            onChanged: (value) => onChanged(value),
          ),
        ],
      ).paddingSymmetric(horizontal: 12.0, vertical: 2.0),
    );
  }

  Widget _buildSoundSwitch() {
    return Obx(
      () => _buildSwitchCard(
        title: 'Sesler',
        icon: Icons.volume_up_outlined,
        value: controller.getOpenSound,
        onChanged: (value) async => await controller.setOpenSound(value),
      ),
    );
  }

  Widget _buildNotificationSwitch() {
    return Obx(
      () => _buildSwitchCard(
        title: 'Bildirimler',
        icon: Icons.notifications_active_outlined,
        value: controller.getOpenNotification,
        onChanged: (value) async => await controller.setOpenNotification(value),
      ),
    );
  }
}
