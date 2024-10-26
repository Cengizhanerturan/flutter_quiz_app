class FeedbackCategoryModel {
  FeedbackCategoryModel({
    required this.id,
    required this.fcid,
    required this.name,
  });

  final int id;
  final String fcid;
  final String name;

  factory FeedbackCategoryModel.fromJson(Map<String, dynamic> json) =>
      FeedbackCategoryModel(
        id: json["id"],
        fcid: json["fcid"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "fcid": fcid,
        "name": name,
      };

  static List<FeedbackCategoryModel> decode(dynamic data) {
    return (data as List)
        .map((element) => FeedbackCategoryModel.fromJson(element))
        .toList();
  }
}
