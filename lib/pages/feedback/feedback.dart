import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/constants/waiting_dialog.dart';
import 'package:admin_panel/models/feedback.dart';
import 'package:admin_panel/models/maintain_toggle.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/pages/feedback/widget/user_review_cart.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController textController = TextEditingController();


  List<UserFeedback>? feedback;
  List<User>? userList;
  final AdminServices adminServices = AdminServices();
  MaintainToggle? maintainToggle;
  
  fetchMaintainToggle() async {
    maintainToggle = await adminServices.fetchMaintainToggle(context: context, toggle: false);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchAllFeedback();
    fetchAllUsers();
    fetchMaintainToggle();
  }

  fetchAllFeedback() async {
    feedback = await adminServices.fetchAllFeedback(context);
    setState(() {});
  }
  
  fetchAllUsers() async {
    userList = await adminServices.fetchAllUsers(context);
    setState(() {});
  }

  void _handleFeedbackDeleted() {
    fetchAllFeedback(); // Fetch the updated list of products
  }

  Future<void> clearAllFeedback() async {

    await Future.forEach(feedback!, (UserFeedback feedbackItem) async{
      await adminServices.deleteFeedback(
        context: context, 
        feedback: feedbackItem, 
        onSuccess: _handleFeedbackDeleted
      );
    });

    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(maintainToggle == null){
      return const Loader();
    }else{
      return Container(
        padding: const EdgeInsets.all(8.0),
        color: AppColor.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
              child: const CustomText(
                text: "Feedback",
                size: 24,
                color: AppColor.secondary,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              child: maintainToggle!.toggle == true
              ? Container(
                  color: Colors.red,
                  child: const CustomText(
                    text: "The server is currently under maintenance.",
                    size: 24,
                    color: Colors.white,
                    weight: FontWeight.bold,
                  ),
                )
              : const CustomText(
                text: "",
                size: 1,
                color: Colors.white,
                weight: FontWeight.bold,
              )
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    bool confirmLogout = await confirm(
                      context, 
                      title: const Text('Clear All Feedback'), 
                      content:const Text('Are you sure you want to clear all the feedback?')
                    );
                    if (confirmLogout) {
                      if(!context.mounted) return;
                      waitingDialog(context, clearAllFeedback, "Clearing All Feedback...");
                    }
                  },
                  child: const CustomText(
                    text: "Clear",
                    size: 14,
                    color: AppColor.secondary,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Expanded(
                child: feedback == null || userList == null
                ? const Loader()
                : ListView.builder(
                  itemCount: feedback!.length,
                  itemBuilder: (context, index) {

                  final feedbackData = feedback![index];

                  bool uFound = false;
                  late User userFound;
                  for (int i = 0; i < userList!.length; i++) {
                    final users = userList![i];
                    if (users.id == feedbackData.userID) {
                      userFound = users;
                      uFound = true;
                      break;
                    }
                    uFound = false;
                  }

                  if(!uFound){
                    userFound = User(
                      id: feedbackData.userID,
                      name: 'Deleted User',
                      email: 'Deleted User',
                      password: 'Deleted User',
                      confirmPassword: 'Deleted User',
                      type: 'user',
                      loginToken: 'Deleted User',
                      verified: null,
                      createdAt: null,
                      lastRequestedOTP: null,
                      requestedOTPCount: 0
                    );
                  }
                    return UserReviewCard(
                      context: context,
                      userFound: userFound,
                      feedbackData: feedbackData,
                      onFeedbackDeleted: _handleFeedbackDeleted,
                    );
                  })),
          ],
        ),
      );
    }
  }
}
