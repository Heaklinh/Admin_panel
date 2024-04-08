import 'dart:convert';

import 'package:admin_panel/constants/error_handling.dart';
import 'package:admin_panel/constants/global_variables.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/models/feedback.dart';
import 'package:admin_panel/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class FeedbackServices {
    Future<List<UserFeedback>> fetchAllFeedback(BuildContext context) async {
    List<UserFeedback> userFeedback = [];
    try {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse('$uri/api/admin/get-feedback'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.loginToken,
        },
      );
      if (!context.mounted) return userFeedback;
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              userFeedback.add(
                UserFeedback.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return userFeedback;
  }

  //Delete Feedback
  Future<void> deleteFeedback(
      {required BuildContext context,
      required UserFeedback feedback,
      required VoidCallback onSuccess}) async {
    try {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.post(Uri.parse('$uri/admin/delete-feedback'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.loginToken,
              },
              body: jsonEncode({
                'id': feedback.id,
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
}
