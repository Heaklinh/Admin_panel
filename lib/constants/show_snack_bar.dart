import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  // Hide the current SnackBar
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    ),
  );
}