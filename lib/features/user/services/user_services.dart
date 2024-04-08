import 'dart:convert';
import 'package:admin_panel/constants/error_handling.dart';
import 'package:admin_panel/constants/global_variables.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserServices {
  Future<List<User>> fetchAllUsers(BuildContext context) async {
    List<User> userList = [];
    try {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-users'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.loginToken,
        },
      );
      if (!context.mounted) return userList;
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              userList.add(
                User.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return userList;
  }
  
  Future<void> deleteUser(
      {required BuildContext context,
      required User user,
      required VoidCallback onSuccess}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      
      http.Response res =
          await http.post(Uri.parse('$uri/admin/delete-user'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.loginToken,
              },
              body: jsonEncode({
                'id': user.id,
              }));
      if (!context.mounted) return;
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<User>> fetchSearchUser({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<User> userList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/search/$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.loginToken,
        },
      );
      if (!context.mounted) return userList;
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              userList.add(
                User.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return userList;
  }
}
