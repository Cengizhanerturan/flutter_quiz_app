import 'dart:convert';
import 'package:flutter_quiz_app/core/constants/api_constants.dart';
import 'package:flutter_quiz_app/core/model/response.dart';
import 'package:http/http.dart' as http;

class QuestionService {
  static Future<ResponseModel> getQuestion({required String cid}) async {
    var url = ApiConstants.baseURL;
    var response = await http.post(Uri.parse(url), body: {
      'action': 'get_question',
      'uid': _userController.uid.value,
      'cid': cid,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == 'success') {
        _questionController.selectedQuestionList.value = data["question_list"];
        return ResponseModel(status: 'success', message: data["message"]);
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
