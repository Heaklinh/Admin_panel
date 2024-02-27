import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/pages/dashboard/widgets/order_history.dart';
import 'package:admin_panel/pages/dashboard/widgets/overview_cards_large.dart';
import 'package:admin_panel/pages/dashboard/widgets/overview_cards_medium.dart';
import 'package:admin_panel/pages/dashboard/widgets/overview_cards_small.dart';
import 'package:admin_panel/pages/dashboard/widgets/revenue_info_section_large.dart';
import 'package:admin_panel/pages/dashboard/widgets/revenue_info_section_small.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  static const String routeName = '/dashboard';
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 56 : 0),
                child: const CustomText(
                  text: "Overview",
                  size: 24,
                  color: AppColor.secondary,
                  weight: FontWeight.bold,
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                if (ResponsiveWidget.isLargeScreen(context) ||
                    ResponsiveWidget.isMediumScreen(context))
                  if (ResponsiveWidget.isCustomScreen(context))
                    const OverviewCardMediumScreen()
                  else
                    const OverviewCardLargeScreen()
                else
                  const OverviewCardSmallScreen(),
                if (ResponsiveWidget.isSmallScreen(context))
                  const RevenueSectionSmall()
                else
                  const RevenueSectionLarge(),
                OrderHistory()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
