import 'package:flutter_quiz_app/core/model/announcement.dart';
import 'package:flutter_quiz_app/core/service/remote/announcement/remote.dart';
import 'package:get/get.dart';

class AnnouncementListController extends GetxController with StateMixin {
  var announcementList = <AnnouncementModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAnnouncementList();
  }

  Future<void> getAnnouncementList() async {
    var response = await AnnouncementService.getAnnouncementList();
    if (response.status == 'success') {
      announcementList.value =
          AnnouncementModel.decoderAnnouncementList(response.data);
      if (announcementList.isEmpty) {
        change(state, status: RxStatus.empty());
      } else {
        change(state, status: RxStatus.success());
      }
    } else {
      change(state, status: RxStatus.error());
    }
  }

  Future<void> onError() async {
    await getAnnouncementList();
  }
}
