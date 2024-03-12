import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/feedback.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/pages/feedback/widget/user_review_cart.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/orders/widgets/drop_down.dart';
import 'package:admin_panel/pages/orders/widgets/item_tile.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  static const routeName = "/feedback";
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController textController = TextEditingController();


  List<UserFeedback>? feedback;
  final AdminServices adminServices = AdminServices();

  final List<String> sortItems = [
    'Ascending',
    'Descending',
  ];


  @override
  void initState() {
    super.initState();
    fetchAllUsers();
  }

  fetchAllUsers() async {
    feedback = await adminServices.fetchAllFeedback(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return UserReviewCard(
                      username: "Linh",
                      date: DateTime(2024, 02, 16),
                      feedbackText:
                          "I love the order tracking feature - it makes the wait so much more bearable and even builds excitement! Seeing my food move closer and closer gets me even hungrier. It's great to know exactly when I should get the table ready",
                    );
                  })),
        ],
      ),
    );
  }
}
