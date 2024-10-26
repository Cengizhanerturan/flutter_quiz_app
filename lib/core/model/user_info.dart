class UserInfoModel {
  UserInfoModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.name,
    required this.surname,
    required this.profileImage,
    required this.bio,
    required this.followCount,
    required this.followersCount,
    required this.allTimeScore,
    required this.monthlyScore,
    required this.dailyScore,
    required this.gold,
    required this.bp,
    required this.heart,
    required this.totalSolvedAnswerCount,
    required this.correctAnswerCount,
    required this.wrongAnswerCount,
    required this.blankAnswerCount,
    required this.jokerTotalUsedCount,
    required this.jokerCorrectAnswerCount,
    required this.jokerCorrectAnswerUsedCount,
    required this.jokerDoubleAnswerCount,
    required this.jokerDoubleAnswerUsedCount,
    required this.jokerHalfAnswerCount,
    required this.jokerHalfAnswerUsedCount,
    required this.createdTime,
    required this.allTimeUserRank,
    required this.monthlyUserRank,
    required this.dailyUserRank,
  });

  final String uid;
  final String username;
  final String email;
  final String? name;
  final String? surname;
  final String? profileImage;
  final String? bio;
  final int followCount;
  final int followersCount;
  final int allTimeScore;
  final int monthlyScore;
  final int dailyScore;
  final int gold;
  final int bp;
  final int heart;
  final int totalSolvedAnswerCount;
  final int correctAnswerCount;
  final int wrongAnswerCount;
  final int blankAnswerCount;
  final int jokerTotalUsedCount;
  final int jokerCorrectAnswerCount;
  final int jokerCorrectAnswerUsedCount;
  final int jokerDoubleAnswerCount;
  final int jokerDoubleAnswerUsedCount;
  final int jokerHalfAnswerCount;
  final int jokerHalfAnswerUsedCount;
  final DateTime createdTime;
  final int allTimeUserRank;
  final int monthlyUserRank;
  final int dailyUserRank;

  factory UserInfoModel.fromMap(Map<String, dynamic> json) => UserInfoModel(
        uid: json["uid"],
        username: json["username"],
        email: json["email"],
        name: json["name"] ?? '',
        surname: json["surname"] ?? '',
        profileImage: json["profile_image"] ?? '',
        bio: json["bio"] ?? '',
        followCount: json["follow_count"],
        followersCount: json["followers_count"],
        allTimeScore: json["all_time_score"],
        monthlyScore: json["monthly_score"],
        dailyScore: json["daily_score"],
        gold: json["gold"],
        bp: json["bp"],
        heart: json["heart"],
        totalSolvedAnswerCount: json["correct_answer_count"] +
            json["wrong_answer_count"] +
            json["blank_answer_count"],
        correctAnswerCount: json["correct_answer_count"],
        wrongAnswerCount: json["wrong_answer_count"],
        blankAnswerCount: json["blank_answer_count"],
        jokerTotalUsedCount: json["joker_correct_answer_used"] +
            json["joker_double_answer_used"] +
            json["joker_half_answer_used"],
        jokerCorrectAnswerCount: json["joker_correct_answer"],
        jokerCorrectAnswerUsedCount: json["joker_correct_answer_used"],
        jokerDoubleAnswerCount: json["joker_double_answer"],
        jokerDoubleAnswerUsedCount: json["joker_double_answer_used"],
        jokerHalfAnswerCount: json["joker_half_answer"],
        jokerHalfAnswerUsedCount: json["joker_half_answer_used"],
        createdTime: DateTime.parse(json["created_time"]),
        allTimeUserRank: json["all_time_user_rank"],
        monthlyUserRank: json["monthly_user_rank"],
        dailyUserRank: json["daily_user_rank"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "username": username,
        "email": email,
        "name": name,
        "surname": surname,
        "profile_image": profileImage,
        "bio": bio,
        "follow": followCount,
        "followers": followersCount,
        "all_time_score": allTimeScore,
        "monthly_score": monthlyScore,
        "dailyScore": dailyScore,
        "gold": gold,
        "bp": bp,
        "heart": heart,
        "correct_answer_count": correctAnswerCount,
        "wrong_answer_count": wrongAnswerCount,
        "blank_answer_count": blankAnswerCount,
        "joker_correct_answer": jokerCorrectAnswerCount,
        "joker_correct_answer_used": jokerCorrectAnswerUsedCount,
        "joker_double_answer": jokerDoubleAnswerCount,
        "joker_double_answer_used": jokerDoubleAnswerUsedCount,
        "joker_half_answer": jokerHalfAnswerCount,
        "joker_half_answer_used": jokerHalfAnswerUsedCount,
        "created_time": createdTime.toIso8601String(),
        "all_time_user_rank": allTimeUserRank,
        "monthly_user_rank": monthlyUserRank,
        "daily_user_rank": dailyUserRank,
      };
}
