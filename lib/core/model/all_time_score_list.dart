class AllTimeScoreListModel {
  final String uid;
  final String username;
  final String profileImage;
  final int score;
  final int userRank;

  AllTimeScoreListModel({
    required this.uid,
    required this.username,
    required this.profileImage,
    required this.score,
    required this.userRank,
  });

  factory AllTimeScoreListModel.fromMap(Map<String, dynamic> json) =>
      AllTimeScoreListModel(
        uid: json["uid"],
        username: json["username"],
        profileImage: json["profile_image"] ?? '',
        score: json["all_time_score"],
        userRank: json["all_time_user_rank"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "username": username,
        "profile_image": profileImage,
        "all_time_score": score,
        "all_time_user_rank": userRank,
      };

  static List<AllTimeScoreListModel> decoder(dynamic data) {
    return (data as List)
        .map((element) => AllTimeScoreListModel.fromMap(element))
        .toList();
  }
}
