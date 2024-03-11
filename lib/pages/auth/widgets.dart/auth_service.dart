import 'dart:convert';
import 'package:admin_panel/constants/error_handling.dart';
import 'package:admin_panel/constants/global_variables.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/pages/dashboard/dashboard.dart';
import 'package:admin_panel/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      email = email.trim().toLowerCase();
      http.Response res = await http.post(
        Uri.parse('$uri/admin/auth/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (!context.mounted) return;
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackBar(context, 'login successful');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (!context.mounted) return;
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString(
              'x-auth-token', jsonDecode(res.body)['loginToken']);
          if (!context.mounted) return;
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   SideBar.routeName,
          //   (route) => false,
          // );
          Navigator.pushNamed(context, AdminDashboard.routeName);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
