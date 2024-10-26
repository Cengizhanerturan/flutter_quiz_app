import 'dart:convert';
import 'package:flutter_quiz_app/core/constants/api_constants.dart';
import 'package:flutter_quiz_app/core/controller/app/controller.dart';
import 'package:flutter_quiz_app/core/model/response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

final AppController _appController = Get.find<AppController>();

class AppService {
  static Future<ResponseModel> getProfileImagesList() async {
    var url = ApiConstants.baseURL;
    var response = await http.post(Uri.parse(url), body: {
      'action': 'get_profile_image_list',
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == 'success') {
        _appController.profileImages = data["image_list"];
        return ResponseModel(status: 'success');
      } else {
        return ResponseModel(
            status: 'error',
            message: 'Bir hata oluştu! Lütfen daha sonra tekrar deneyiniz.');
      }
    } else {
      return ResponseModel(
          status: 'error',
          message: 'Bir hata oluştu! Lütfen daha sonra tekrar deneyiniz.');
    }
  }
}
