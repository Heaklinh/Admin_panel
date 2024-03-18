import 'dart:convert';

class UserFeedback {
  final String userID;
  final int sentDate;
  final String userFeedback;
  final String? id;
  UserFeedback({
    required this.userID,
    required this.sentDate,
    required this.userFeedback,
    this.id
  });
  
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'sentDate': sentDate,
      'userFeedback': userFeedback,
      'id': id,
    };
  }

  factory UserFeedback.fromMap(Map<String, dynamic> map) {
    return UserFeedback(
      userID: map['userID'] ?? '',
      sentDate: map['sentDate'] ?? '',
      userFeedback: map['userFeedback'] ?? '',
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFeedback.fromJson(String source) =>
      UserFeedback.fromMap(json.decode(source));
}
