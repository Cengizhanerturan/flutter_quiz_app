import 'package:flutter_quiz_app/core/base/base_get_view.dart';
import 'package:flutter_quiz_app/core/config/theme/theme_extension.dart';
import 'package:flutter_quiz_app/core/constants/assets_constants.dart';
import 'package:flutter_quiz_app/core/constants/string_constants.dart';
import 'package:flutter_quiz_app/core/controller/announcement_list/controller.dart';
import 'package:flutter_quiz_app/core/model/announcement.dart';
import 'package:flutter_quiz_app/core/util/get_extension.dart';
import 'package:flutter_quiz_app/widgets/custom_appbar.dart';
import 'package:flutter_quiz_app/widgets/custom_inkwell.dart';
import 'package:flutter_quiz_app/widgets/empty_widget.dart';
import 'package:flutter_quiz_app/widgets/error_widget.dart';
import 'package:flutter_quiz_app/widgets/loading.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_autosize_text.dart';
import 'package:flutter_quiz_app/widgets/scale_factor_text.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class AnnouncementList extends BaseGetView<AnnouncementListController> {
  const AnnouncementList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Duyurular'),
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: GetBuilder<AnnouncementListController>(
            builder: (controller) => controller.obx(
              (state) => _buildList(),
              onLoading: const LoadingWidget(),
              onEmpty: const CustomEmptyWidget(
                  message: 'Şuan için herhangi bir duyuru bulunmamaktadır'),
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

  Widget _buildList() {
    return Column(
      children: [
        16.height,
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.announcementList.length,
            itemBuilder: (BuildContext context, int index) {
              final announcement = controller.announcementList[index];
              return Column(
                children: [
                  CustomInkWell(
                    onTap: () {
                      Get.toAnnouncementDetailsPage(
                          id: announcement.id.toString());
                    },
                    child: ClayContainer(
                      width: Get.width,
                      height: 80,
                      borderRadius: 16.0,
                      color: theme.cardColor,
                      parentColor: theme.scaffoldBackgroundColor,
                      depth: 10,
                      spread: 1,
                      curveType: CurveType.concave,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          _buildAnnouncementIcon(),
                          12.width,
                          _buildContent(announcement),
                          12.width,
                          _buildIcon(),
                          12.width,
                        ],
                      ),
                    ),
                  ),
                  12.height,
                ],
              );
            },
          ).paddingSymmetric(horizontal: 16.0),
        ),
      ],
    );
  }

  Widget _buildContent(AnnouncementModel announcement) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          8.height,
          Expanded(
            child: ScaleFactorAutoSizeText(
              text: announcement.title,
              style: theme.textTheme.titleSmall!.medium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          8.height,
          ScaleFactorText(
            text: announcement.createdTime,
            style: theme.textTheme.bodySmall!.medium,
          ),
          8.height,
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return ClayContainer(
      color: theme.scaffoldBackgroundColor,
      parentColor: theme.cardColor,
      borderRadius: 75,
      depth: 40,
      spread: 2,
      curveType: CurveType.concave,
      child: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
        color: theme.primaryColor,
      ).paddingAll(8.0),
    );
  }

  Widget _buildAnnouncementIcon() {
    return Container(
      height: 80,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
        ),
        color: theme.primaryColor,
      ),
      child: ImageIcon(
        const AssetImage(
          AssetsConstants.announcementIcon,
        ),
        color: theme.primaryColorLight,
      ).paddingAll(10.0),
    );
  }
}
