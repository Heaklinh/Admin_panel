import 'dart:convert';

class UserFeedback {
  final String userID;
  final DateTime date;
  final String feedback;
  UserFeedback({
    required this.userID,
    required this.date,
    required this.feedback,
  });
  UserFeedback copyWith({
    String? userID,
    DateTime? date,
    String? feedback,
  }) {
    return UserFeedback(
      userID: userID ?? this.userID,
      date: date ?? this.date,
      feedback: feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'date': date,
      'feedback': feedback,
    };
  }

  factory UserFeedback.fromMap(Map<String, dynamic> map) {
    return UserFeedback(
      userID: map['userID'] ?? '',
      date: map['date'] ?? '',
      feedback: map['feedback'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFeedback.fromJson(String source) =>
      UserFeedback.fromMap(json.decode(source));
}
