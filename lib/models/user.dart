import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String type;
  final String loginToken;
  final bool? verified;
  final DateTime? createdAt;
  final int requestedOTPCount;
  final DateTime? lastRequestedOTP;

  User( 
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.type,
      required this.loginToken,
      required this.verified,
      required this.createdAt,
      required this.lastRequestedOTP,
      required this.requestedOTPCount,
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'type': type,
      'loginToken': loginToken,
      'verified': verified,
      'createdAt': createdAt,
      'requestedOTPCount': requestedOTPCount,
      'lastRequestedOTP': lastRequestedOTP,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['confirmPassword'] ?? '',
      type: map['type'] ?? '',
      loginToken: map['loginToken'] ?? '',
      verified: map['verified'],
      createdAt: null,
      requestedOTPCount: map['requestedOTPCount'] ?? 0,
      lastRequestedOTP: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
