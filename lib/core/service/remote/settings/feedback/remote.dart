import 'dart:convert';
import 'package:flutter_quiz_app/core/constants/api_constants.dart';
import 'package:flutter_quiz_app/core/model/feedback_category.dart';
import 'package:flutter_quiz_app/core/model/response.dart';
import 'package:http/http.dart' as http;

class FeedbackService {
  static Future<ResponseModel> getFeedbackCategory() async {
    var url = ApiConstants.baseURL;
    var response = await http.post(Uri.parse(url), body: {
      'action': 'get_feedback_category',
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == 'success') {
        var model = FeedbackCategoryModel.decode(data["data"]);
        return ResponseModel(status: 'success', data: model);
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

  static Future<ResponseModel> sendFeedback(
      {required String uid,
      required String fcid,
      required String fcName,
      required String content}) async {
    var url = ApiConstants.baseURL;
    uid = uid.trim();
    fcid = fcid.trim();
    content = content.trim();
    var response = await http.post(Uri.parse(url), body: {
      'action': 'send_feedback',
      'uid': uid,
      'fcid': fcid,
      'fc_name': fcName,
      'content': content,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == 'success') {
        return ResponseModel(status: 'success', message: data['message']);
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
