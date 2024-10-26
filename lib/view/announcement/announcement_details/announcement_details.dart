import 'package:flutter_quiz_app/core/base/base_get_view.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/core/constants/string_constants.dart';
import 'package:flutter_quiz_app/core/controller/announcement_details/controller.dart';
import 'package:flutter_quiz_app/widgets/custom_appbar.dart';
import 'package:flutter_quiz_app/widgets/error_widget.dart';
import 'package:flutter_quiz_app/widgets/loading.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class AnnouncementDetails extends BaseGetView<AnnouncementDetailsController> {
  final String controllerTag;
  const AnnouncementDetails({Key? key, required this.controllerTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Duyuru'),
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: GetBuilder<AnnouncementDetailsController>(
            builder: (controller) => controller.obx(
              (state) => _buildAnnouncement(),
              onLoading: const LoadingWidget(),
              onError: (error) => CustomErrorWidget(
                message: StringConstants.errorText,
                isRetry: true,
                retryFunction: () => controller.onError(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncement() {
    var announcement = controller.announcement.value;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ScaleFactorText(
              text: announcement!.createdTime,
              style: theme.textTheme.bodyMedium!.medium
                  .copyWith(color: theme.disabledColor),
            ),
          ),
          12.height,
          ScaleFactorText(
            text: announcement.title,
            style: theme.textTheme.titleSmall!.semibold,
          ),
          12.height,
          ScaleFactorText(
            text: announcement.content!,
            style: theme.textTheme.bodyMedium!.regular,
          ),
          12.height,
        ],
      ).paddingSymmetric(horizontal: 16.0),
    );
  }
}
