import 'dart:convert';
import 'package:flutter_quiz_app/core/constants/api_constants.dart';
import 'package:flutter_quiz_app/core/model/response.dart';
import 'package:http/http.dart' as http;

class AnnouncementService {
  static Future<ResponseModel> getAnnouncementList() async {
    var url = ApiConstants.baseURL;
    var response = await http.post(Uri.parse(url), body: {
      'action': 'get_announcement_list',
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == 'success') {
        return ResponseModel(status: 'success', data: data["data"]);
      } else {
        return ResponseModel(status: 'error', message: data["message"]);
      }
    } else {
      return ResponseModel(
          status: 'error',
          message: 'Bir hata oluştu! Lütfen daha sonra tekrar deneyiniz.');
    }
  }

  static Future<ResponseModel> getAnnouncement({required String id}) async {
    var url = ApiConstants.baseURL;
    var response = await http.post(Uri.parse(url), body: {
      'action': 'get_announcement',
      'id': id,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == 'success') {
        return ResponseModel(
            status: 'success', data: data["announcement_details"]);
      } else {
        return ResponseModel(status: 'error', message: data["message"]);
      }
    } else {
      return ResponseModel(
          status: 'error',
          message: 'Bir hata oluştu! Lütfen daha sonra tekrar deneyiniz.');
    }
  }
}
