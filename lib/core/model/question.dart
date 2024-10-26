// To parse this JSON data, do
//
//     final questionModel = questionModelFromMap(jsonString);

import 'dart:convert';

QuestionModel questionModelFromMap(String str) =>
    QuestionModel.fromMap(json.decode(str));

String questionModelToMap(QuestionModel data) => json.encode(data.toMap());

class QuestionModel {
  QuestionModel({
    required this.id,
    required this.qid,
    required this.cid,
    required this.cname,
    required this.question,
    required this.answer,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
  });

  final int id;
  final String qid;
  final String cid;
  final String cname;
  final String question;
  final String answer;
  final String a;
  final String b;
  final String c;
  final String d;

  factory QuestionModel.fromMap(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        qid: json["qid"].toString(),
        cid: json["cid"].toString(),
        cname: json["cname"].toString(),
        question: json["question"].toString(),
        answer: json["answer"].toString(),
        a: json["a"].toString(),
        b: json["b"].toString(),
        c: json["c"].toString(),
        d: json["d"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "qid": qid,
        "cid": cid,
        "cname": cname,
        "question": question,
        "answer": answer,
        "a": a,
        "b": b,
        "c": c,
        "d": d,
      };

  @override
  String toString() {
    return toMap().toString();
  }
}
