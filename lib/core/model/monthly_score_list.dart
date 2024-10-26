class MonthlyScoreListModel {
  final String uid;
  final String username;
  final String profileImage;
  final int score;
  final int userRank;

  MonthlyScoreListModel({
    required this.uid,
    required this.username,
    required this.profileImage,
    required this.score,
    required this.userRank,
  });

  factory MonthlyScoreListModel.fromMap(Map<String, dynamic> json) =>
      MonthlyScoreListModel(
        uid: json["uid"],
        username: json["username"],
        profileImage: json["profile_image"] ?? '',
        score: json["monthly_score"],
        userRank: json["monthly_user_rank"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "username": username,
        "profile_image": profileImage,
        "monthly_score": score,
        "monthly_user_rank": userRank,
      };

  static List<MonthlyScoreListModel> decoder(dynamic data) {
    return (data as List)
        .map((element) => MonthlyScoreListModel.fromMap(element))
        .toList();
  }
}
