import 'package:flutter_quiz_app/core/model/announcement.dart';
import 'package:flutter_quiz_app/core/service/remote/announcement/remote.dart';
import 'package:get/get.dart';

class AnnouncementDetailsController extends GetxController with StateMixin {
  final String id;
  AnnouncementDetailsController({required this.id});

  var announcement = Rxn<AnnouncementModel>();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAnnouncement(id: id);
  }

  Future<void> getAnnouncement({required String id}) async {
    var response = await AnnouncementService.getAnnouncement(id: id);
    if (response.status == 'success') {
      announcement.value = AnnouncementModel.fromJson(response.data);
      change(state, status: RxStatus.success());
    } else {
      change(state, status: RxStatus.error());
    }
  }

  Future<void> onError() async {
    await getAnnouncement(id: id);
  }
}
