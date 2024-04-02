import 'dart:convert';
import 'package:admin_panel/constants/error_handling.dart';
import 'package:admin_panel/constants/global_variables.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/models/maintain_toggle.dart';
import 'package:admin_panel/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SettingServices{
  Future<void> updateMaintainToggle({
    required BuildContext context,
    required bool? toggle,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/setting/update-maintainToggle'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.loginToken,
        },
        body: jsonEncode({
          'toggle': toggle,
        })
      );
      if (!context.mounted) return;
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          if(toggle == true){
            showSnackBar(context, 'The app is now under maintenance');
          }else{
            showSnackBar(context, 'Maitenance off');
          }
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<MaintainToggle> fetchMaintainToggle({
    required BuildContext context,
    required bool toggle,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    MaintainToggle maintainToggle = MaintainToggle(toggle: toggle);
    try{
      http.Response res = await http.get(
        Uri.parse('$uri/admin/setting/get-maintainToggle'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.loginToken,
        },
      );
      if (!context.mounted) return maintainToggle;
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            if(res.body != "\"no value\""){
              maintainToggle = MaintainToggle.fromJson(jsonEncode(jsonDecode(res.body)));
            }
          });
    }catch(e){
      showSnackBar(context, e.toString());
    }
    return maintainToggle;
  }
}