import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/pages/dashboard/widgets/bar_chart.dart';
import 'package:admin_panel/pages/dashboard/widgets/revenue_info.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RevenueSectionLarge extends StatelessWidget {
  final List<Order>? orderList;
  const RevenueSectionLarge({super.key, required this.orderList});
  
  @override
  Widget build(BuildContext context) {
    double todayIncome = 0;
    List<Order>? todayOrders = filterDate(
      year: DateTime.now().year,
      month: DateTime.now().month,
      day: DateTime.now().day
    );
    List<Order>? last30Days = filterDate(
      month: DateTime.now().month,
    );
    List<Order>? last12Months = filterDate(
      year: DateTime.now().year,
    );
    for(int i = 0; i < todayOrders.length; i++){
      todayIncome+=todayOrders[i].totalPrice;
    }
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
      child: Row(
        children: [
          Expanded(
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
                  height: 300,
                  child: BarChart(),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    RevenueInfo(title: "Today", amount: "${todayOrders.length}"),
                    RevenueInfo(title: "Today income", amount: "\$$todayIncome"),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    RevenueInfo(title: "Last 30 Days", amount: "${last30Days.length}"),
                    RevenueInfo(title: "Last 12 Months", amount: "${last12Months.length}"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to filter orders by date and return a list of orders for the specified period
  List<Order> filterDate({int? year, int? month, int? day}) {
    List<Order> filteredOrders = [];

    for (int i = 0; i < orderList!.length; i++) {
      int orderTimeStamp = orderList![i].orderDate;
      DateTime orderDate = DateTime.fromMillisecondsSinceEpoch(orderTimeStamp);
      int orderYear = orderDate.year;
      int orderMonth = orderDate.month;
      int orderDay = orderDate.day;

      // Check if the order matches the specified year, month, and day
      if ((year == null || orderYear == year) &&
          (month == null || orderMonth == month) &&
          (day == null || orderDay == day)) {
        filteredOrders.add(orderList![i]);
      }
    }

    return filteredOrders;
  }

}
