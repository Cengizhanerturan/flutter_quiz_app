class DailyScoreListModel {
  final String uid;
  final String username;
  final String profileImage;
  final int score;
  final int userRank;

  DailyScoreListModel({
    required this.uid,
    required this.username,
    required this.profileImage,
    required this.score,
    required this.userRank,
  });

  factory DailyScoreListModel.fromMap(Map<String, dynamic> json) =>
      DailyScoreListModel(
        uid: json["uid"],
        username: json["username"],
        profileImage: json["profile_image"] ?? '',
        score: json["daily_score"],
        userRank: json["daily_user_rank"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "username": username,
        "profile_image": profileImage,
        "daily_score": score,
        "daily_user_rank": userRank,
      };

  static List<DailyScoreListModel> decoder(dynamic data) {
    return (data as List)
        .map((element) => DailyScoreListModel.fromMap(element))
        .toList();
  }
}
