import 'package:intl/intl.dart';

class SendQuestionModel {
  String uid;
  String cid;
  String categoryName;
  String qid;
  String question;
  String a;
  String b;
  String c;
  String d;
  String answer;
  int status;
  String statusString;
  String createdTime;

  SendQuestionModel({
    required this.uid,
    required this.cid,
    required this.categoryName,
    required this.qid,
    required this.question,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.answer,
    required this.status,
    required this.statusString,
    required this.createdTime,
  });

  factory SendQuestionModel.fromJson(Map<String, dynamic> json) =>
      SendQuestionModel(
        uid: json["uid"],
        cid: json["cid"],
        categoryName: json["category_name"],
        qid: json["qid"],
        question: json["question"],
        a: json["a"],
        b: json["b"],
        c: json["c"],
        d: json["d"],
        answer: json["answer"],
        status: json["status"],
        statusString: setStatusString(json["status"]),
        createdTime: DateFormat('dd.MM.yyyy HH:mm')
            .format(DateTime.parse(json["created_time"])),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "cid": cid,
        "category_name": categoryName,
        "qid": qid,
        "question": question,
        "a": a,
        "b": b,
        "c": c,
        "d": d,
        "answer": answer,
        "status": status,
        "status_string": statusString,
        "created_time": createdTime,
      };

  static List<SendQuestionModel> decoder(dynamic data) {
    return (data as List)
        .map((element) => SendQuestionModel.fromJson(element))
        .toList();
  }

  static String setStatusString(int status) {
    if (status == 0) {
      return 'Reddedildi';
    } else if (status == 1) {
      return 'Onaylandı';
    } else if (status == 2) {
      return 'Beklemede';
    } else {
      return 'İptal Edildi';
    }
  }
}
