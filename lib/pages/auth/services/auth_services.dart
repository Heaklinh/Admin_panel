import 'dart:convert';

import 'package:admin_panel/constants/error_handling.dart';
import 'package:admin_panel/constants/global_variables.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/pages/auth/authenthication.dart';
import 'package:admin_panel/pages/widgets/side_bar_nav.dart';
import 'package:admin_panel/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  //Sign In
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      email = email.trim().toLowerCase();
      http.Response res = await http.post(
        Uri.parse('$uri/api/auth/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
          'type': 'admin panel',
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
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (!context.mounted) return;
          showSnackBar(context, 'login successful');
          if (!context.mounted) return;
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString(
              'x-auth-token', jsonDecode(res.body)['loginToken']);
          if (!context.mounted) return;
          Navigator.pushNamed(
            context,
            SideBar.routeName,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //Get user data
  Future<void> getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? loginToken = prefs.getString('x-auth-token');

      if (loginToken == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http
          .post(Uri.parse('$uri/validateLoginToken'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': loginToken!,
      });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': loginToken,
        });

        if (!context.mounted) return;
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  //Logout
  void logOut(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');

      User user = userProvider.user.copyWith(
                loginToken: '');
            userProvider.setUserFromModel(user);
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, AuthenticationPage.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
