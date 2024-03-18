import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/feedback.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  final BuildContext context;
  final User userFound;
  final UserFeedback feedbackData;
  final VoidCallback onFeedbackDeleted;
  UserReviewCard(
      {super.key,
      required this.context,
      required this.userFound,
      required this.feedbackData,
      required this.onFeedbackDeleted});

  final AdminServices adminServices = AdminServices();

  void deleteFeedback() {
    submitForm();
    const Duration timeoutDuration =
        Duration(seconds: 2); // Adjust the timeout duration as needed

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: Future.delayed(timeoutDuration),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Execution completed within the timeout duration
              Navigator.pop(context); // Close the dialog
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              // Still waiting for the execution to complete
              return const AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Deleting feedback...'),
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

  void submitForm() {
    adminServices.deleteFeedback(
      context: context,
      feedback: feedbackData,
      onSuccess: onFeedbackDeleted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: const ShapeDecoration(
          shape: BeveledRectangleBorder(
              side: BorderSide(color: AppColor.primary, width: 0.3),
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(12)))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userFound.name,
                style: const TextStyle(
                    color: AppColor.secondary,
                    fontFamily: 'Niradei',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  bool confirmLogout = await confirm(
                    context, 
                    title: const Text('Delete'), 
                    content:const Text('Are you sure you want to delete this feedback?')
                  );
                  if (confirmLogout) {
                    deleteFeedback();
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                DateFormat().format(DateTime.fromMillisecondsSinceEpoch(feedbackData.sentDate)),
                style: const TextStyle(
                  color: AppColor.disable,
                  fontSize: 12,
                  fontFamily: 'Niradei',
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft, // Align text to start from left
            child: ReadMoreText(
              feedbackData.userFeedback,
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' show more',
              trimExpandedText: ' show less',
              moreStyle: const TextStyle(
                color: AppColor.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              lessStyle: const TextStyle(
                color: AppColor.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
