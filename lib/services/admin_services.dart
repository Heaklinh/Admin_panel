
import 'dart:io';

import 'package:admin_panel/constants/error_handling.dart';
import 'package:admin_panel/constants/global_variables.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminServices {
  void addProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required File image,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('dsx7eoho1', 'jibs0s0t');
      CloudinaryResponse cloudinaryRes  = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(image.path, folder: name),
          );
      String imageUrls = cloudinaryRes .secureUrl;

      Product product = Product(
        name: name,
        description: description,
        price: price,
        image: imageUrls,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: product.toJson(),
      );
      if (!context.mounted) return;
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
