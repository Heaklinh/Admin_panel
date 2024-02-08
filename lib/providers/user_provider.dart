
import 'package:admin_panel/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    confirmPassword: '', 
    loginToken: '',
    type: '',
    verified: null,
    createdAt: null, 
    requestedOTPCount: 0,
    lastRequestedOTP: null, 
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
