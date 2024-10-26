import 'package:flutter_quiz_app/core/model/send_question.dart';
import 'package:flutter_quiz_app/view/announcement/announcement_details/announcement_details.dart';
import 'package:flutter_quiz_app/view/announcement/announcement_details/announcement_details_binding.dart';
import 'package:flutter_quiz_app/view/profile/change_user_info/change_user_info.dart';
import 'package:flutter_quiz_app/view/profile/change_user_info/change_user_info_binding.dart';
import 'package:flutter_quiz_app/view/profile/follow/followers.dart';
import 'package:flutter_quiz_app/view/profile/follow/followers_binding.dart';
import 'package:flutter_quiz_app/view/profile/send_question/send_question.dart';
import 'package:flutter_quiz_app/view/profile/send_question/send_question_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

extension CustomGetExtesion on GetInterface {
  Future<void> launchURL(String url) async {
    var uri = Uri.parse(url);
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> toSendQuestionPage(
      {bool isEdit = false, SendQuestionModel? sendQuestionModel}) async {
    await Get.to(
      () => const SendQuestion(),
      binding: SendQuestionBinding(
        isEdit: isEdit,
        sendQuestionModel: sendQuestionModel,
      ),
    );
  }

  Future<void> toFollowersPage({
    required String uid,
    required bool isFollow,
  }) async {
    var tag = UniqueKey().toString();
    await Get.to(
      () => Followers(
        uid: uid,
        controllerTag: tag,
        isFollow: isFollow,
      ),
      binding: FollowersBinding(
        uid: uid,
        isFollow: isFollow,
        tag: tag,
      ),
      routeName: 'followers_$uid',
    );
  }

  Future<void> toAnnouncementDetailsPage({
    required String id,
  }) async {
    var tag = UniqueKey().toString();
    await Get.to(
      () => AnnouncementDetails(
        controllerTag: tag,
      ),
      binding: AnnouncementDetailsBinding(
        id: id,
        tag: tag,
      ),
      routeName: 'announcement_details_$id',
    );
  }

  Future<void> toChangeUserInfo(String profileTag) async {
    await Get.to(
      () => const ChangeUserInfo(),
      binding: ChangeUserInfoBinding(profileTag: profileTag),
      routeName: 'change_user_info',
    );
  }
}
