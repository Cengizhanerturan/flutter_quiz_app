import 'dart:convert';

ResponseModel responseModelFromMap(String str) =>
    ResponseModel.fromMap(json.decode(str));

String responseModelToMap(ResponseModel data) => json.encode(data.toMap());

class ResponseModel {
  ResponseModel({
    required this.status,
    this.message,
    this.data,
  });

  final String status;
  final String? message;
  final dynamic data;

  factory ResponseModel.fromMap(Map<String, dynamic> json) => ResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data,
      };

  @override
  String toString() {
    return 'status: $status | message: $message | data: $data';
  }
}
