import 'dart:convert';
import 'package:flutter_quiz_app/core/constants/api_constants.dart';
import 'package:flutter_quiz_app/core/model/response.dart';
import 'package:http/http.dart' as http;

class RegisterService {
  static Future<ResponseModel> register(
      {required String username,
      required String email,
      required String password}) async {
    var url = ApiConstants.baseURL;
    username = username.trim();
    email = email.trim();
    password = password.trim();
    var response = await http.post(Uri.parse(url), body: {
      'action': 'register_send_mail',
      'username': username,
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == 'success') {
        _registerController.mailID.value = data["id"].toString();
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

  static Future<ResponseModel> checkCode({required String code}) async {
    var url = ApiConstants.baseURL;
    code = code.trim();
    var response = await http.post(Uri.parse(url), body: {
      'action': 'register_check_code',
      'id': _registerController.mailID.value,
      'code': code
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == 'success') {
        _userController.uid.value = data["uid"];
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

  static Future<ResponseModel> resendCode({required String id}) async {
    var url = ApiConstants.baseURL;
    id = id.trim();
    var response = await http.post(Uri.parse(url),
        body: {'action': 'register_resend_code', 'id': id});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data["status"] == 'success') {
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
