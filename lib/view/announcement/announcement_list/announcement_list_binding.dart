import 'package:flutter_quiz_app/core/controller/announcement_list/controller.dart';
import 'package:get/get.dart';

class AnnouncementListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AnnouncementListController());
  }
}
