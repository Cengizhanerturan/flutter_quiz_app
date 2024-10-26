import 'dart:convert';
import 'package:flutter_quiz_app/core/constants/api_constants.dart';
import 'package:flutter_quiz_app/core/model/response.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<ResponseModel> login(
      {required String username, required String password}) async {
    var url = ApiConstants.baseURL;
    username = username.trim();
    password = password.trim();
    var response = await http.post(Uri.parse(url), body: {
      'action': 'login',
      'username': username,
      'password': password,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == 'success') {
        _userController.uid.value = data["data"]["uid"];
        return ResponseModel(status: 'success');
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
