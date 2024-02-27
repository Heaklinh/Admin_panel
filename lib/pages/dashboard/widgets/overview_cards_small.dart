import 'package:admin_panel/pages/dashboard/widgets/info_cart_small.dart';
import 'package:flutter/material.dart';

class OverviewCardSmallScreen extends StatelessWidget {
  const OverviewCardSmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "In Queue",
            value: "7",
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: width / 64,
          ),
          InfoCardSmall(
            title: "In Storage",
            value: "7",
            onTap: () {},
          ),
          SizedBox(
            height: width / 64,
          ),
          InfoCardSmall(
            title: "Completed",
            value: "7",
            onTap: () {},
          ),
          SizedBox(
            height: width / 64,
          ),
          InfoCardSmall(
            title: "Total Order",
            value: "7",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
