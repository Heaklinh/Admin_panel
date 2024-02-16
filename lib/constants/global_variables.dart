import 'package:flutter/material.dart';

String uri = 'http://172.23.33.104:3000';

class AppColor {
  static const primary = Color(0xFFFF4438);
  static const secondary = Color(0xFF12284c);
  static const white = Color(0xFFFFFFFF);
  static const placeholderText = Color(0xFF5D5D5D);
  static const placeholderBg = Color(0xFFFFFFFF);
  static const disable = Color(0xff9999A3);
}

class Helper {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static String getAssetName(String fileName) {
    return "assets/images/$fileName";
  }

  static TextTheme getTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }
}
