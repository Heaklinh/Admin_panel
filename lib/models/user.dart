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
  String? profile;
  List<String?>? devices;
  
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
      this.profile,
      this.devices,
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
      'profile': profile,
      'devices': devices,
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
      profile: map['profile'] ?? '',
      devices: List<String>.from(map['devices']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({  
    String? id,
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? type,
    String? loginToken,
    bool? verified,
    DateTime? createdAt,
    int? requestedOTPCount,
    DateTime? lastRequestedOTP,
    String? profile,
    List<String?>? devices,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      type: type?? this.type,
      loginToken: loginToken?? this.loginToken,
      verified: null, 
      createdAt: null,
      requestedOTPCount: requestedOTPCount?? this.requestedOTPCount,
      lastRequestedOTP: null,
      profile: profile ?? this.profile,
      devices: devices ?? this.devices,
    );
  }
}


