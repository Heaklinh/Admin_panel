import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/pages/dashboard/widgets/bar_chart.dart';
import 'package:admin_panel/pages/dashboard/widgets/revenue_info.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RevenueSectionSmall extends StatelessWidget {
  const RevenueSectionSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: AppColor.disable.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(
          color: AppColor.disable,
          width: .5,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomText(
                  text: "Revenue Chart",
                  size: 20,
                  color: AppColor.disable,
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  width: 600,
                  height: 200,
                  child: BarChart(),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            width: 120,
            color: AppColor.disable,
          ),
          const SizedBox(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    RevenueInfo(title: "Today", amount: "24"),
                    RevenueInfo(title: "Today", amount: "24"),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    RevenueInfo(title: "Last 30 Days", amount: "1,024"),
                    RevenueInfo(title: "Last 12 Months", amount: "10,382"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
