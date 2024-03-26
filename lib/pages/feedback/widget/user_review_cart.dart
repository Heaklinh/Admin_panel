import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/constants/waiting_dialog.dart';
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

  Future<void> submitForm()async{
    await adminServices.deleteFeedback(
      context: context,
      feedback: feedbackData,
      onSuccess: onFeedbackDeleted,
    );
    if(!context.mounted) return;
    Navigator.pop(context);
    showSnackBar(context, "Feedback deleted successfully");
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
                    content:const Text('Are you sure you want to delete this Feedback?')
                  );
                  if (confirmLogout) {
                    if(!context.mounted) return;
                    waitingDialog(context, submitForm, "Deleting Feedback...");
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
