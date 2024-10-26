import 'package:flutter_quiz_app/core/controller/announcement_details/controller.dart';
import 'package:get/get.dart';

class AnnouncementDetailsBinding implements Bindings {
  final String id;
  final String tag;

  AnnouncementDetailsBinding({required this.id, required this.tag});

  @override
  void dependencies() {
    Get.put(AnnouncementDetailsController(id: id));
  }
}
