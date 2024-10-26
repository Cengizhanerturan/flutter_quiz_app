import 'package:intl/intl.dart';

class AnnouncementModel {
  final int id;
  final String title;
  final String? content;
  final String createdTime;

  AnnouncementModel({
    required this.id,
    required this.title,
    this.content,
    required this.createdTime,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        createdTime: DateFormat('dd.MM.yyyy HH:mm')
            .format(DateTime.parse(json["created_time"])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "created_time": createdTime,
      };

  static List<AnnouncementModel> decoderAnnouncementList(dynamic data) {
    return (data as List)
        .map((element) => AnnouncementModel.fromJson(element))
        .toList();
  }
}
