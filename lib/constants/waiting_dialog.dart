import 'package:admin_panel/common/widgets/loader.dart';
import 'package:flutter/material.dart';

void waitingDialog(BuildContext context, VoidCallback function, String text) {
  const Duration timeoutDuration =
      Duration(seconds: 0); // Adjust the timeout duration as needed

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder(
        future: Future.delayed(timeoutDuration, () => function()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // Still waiting for the execution to complete
            return AlertDialog(
              
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Loader(),
                  const SizedBox(height: 16),
                  Text(text),
                ],
              ),
            );
          } else {
            // Timeout occurred
            Navigator.pop(context); // Close the dialog
            // Handle timeout, you can show an error message or take appropriate action
            debugPrint('Save changes timed out');
          }
          return Container(); // Placeholder, you can customize the UI based on your needs
        },
      );
    },
  );
}

