import 'dart:convert';
import 'dart:io';

import 'package:admin_panel/constants/error_handling.dart';
import 'package:admin_panel/constants/global_variables.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/models/maintain_toggle.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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

  //Delete order
  Future<void> deleteOrder(
      {required BuildContext context,
      required Order order,
      required VoidCallback onSuccess}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.post(Uri.parse('$uri/admin/delete-order'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.loginToken,
              },
              body: jsonEncode({
                'id': order.id,
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

  //Refund order
  Future<void> refundOrder(
      {required BuildContext context,
      required Order order,
      required VoidCallback onSuccess}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.post(Uri.parse('$uri/admin/refund-order'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.loginToken,
              },
              body: jsonEncode({
                'id': order.id,
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
