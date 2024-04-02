import 'dart:convert';
import 'dart:io';

import 'package:admin_panel/constants/error_handling.dart';
import 'package:admin_panel/constants/global_variables.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DrinkServices{
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
}