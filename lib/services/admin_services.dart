import 'dart:convert';
import 'dart:io';

import 'package:admin_panel/constants/error_handling.dart';
import 'package:admin_panel/constants/global_variables.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/models/feedback.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/pages/auth/authenthication.dart';
import 'package:admin_panel/pages/widgets/side_bar_nav.dart';
import 'package:admin_panel/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {
  Future<void> addProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required File image,
    required VoidCallback onProductAdded,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dsx7eoho1', 'jibs0s0t');
      CloudinaryResponse cloudinaryRes = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: 'Product'),
      );
      String imageUrls = cloudinaryRes.secureUrl;
      String publicID = cloudinaryRes.publicId;

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.loginToken,
        },
        body: jsonEncode({
          'name': name,
          'description': description,
          'price': price,
          'image': imageUrls,
          'publicID':publicID,
        }),
      );
      if (!context.mounted) return;
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onProductAdded();
          Navigator.pop(context);
          Navigator.pop(context);
          showSnackBar(context, 'Product Added Successfully!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> editProduct({
    required BuildContext context,
    required String? id,
    required String name,
    required String description,
    required double price,
    required File image,
    required VoidCallback onProductUpdated,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      String imageUrls = '';
      String publicID = '';
      if(image.path != ''){
        final cloudinary = CloudinaryPublic('dsx7eoho1', 'jibs0s0t');
        CloudinaryResponse cloudinaryRes = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: 'Product'),
        );
        imageUrls = cloudinaryRes.secureUrl;
        publicID = cloudinaryRes.publicId;
      }
      http.Response res = await http.post(
        Uri.parse('$uri/admin/update-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.loginToken,
        },
        body: jsonEncode({
          'id': id,
          'name': name,
          'description': description,
          'price': price,
          'image': imageUrls,
          'publicID': publicID,
        })
      );
      if (!context.mounted) return;
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onProductUpdated();
          Navigator.pop(context);
          Navigator.pop(context);
          showSnackBar(context, 'Product Updated Successfully!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    List<Product> productList = [];
    try {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.loginToken,
        },
      );
      if (!context.mounted) return productList;
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<void> deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    try {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.post(Uri.parse('$uri/admin/delete-product'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.loginToken,
              },
              body: jsonEncode({
                'id': product.id,
              }));
      if (!context.mounted) return;
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    List<Order> orderList = [];
    try {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-orders'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.loginToken,
        },
      );
      if (!context.mounted) return orderList;
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList.add(
                Order.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

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
          Navigator.pushNamedAndRemoveUntil(
            context,
            SideBar.routeName,
            (route) => false,
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
