import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/features/dashboard/widgets/info_cart_small.dart';
import 'package:flutter/material.dart';

class OverviewCardSmallScreen extends StatelessWidget {
  final List<Order>? orderHistoryList;
  final List<Order>? inStorage;
  final List<Order>? orderQueueList;
  final List<Order>? orderList;
  const OverviewCardSmallScreen({super.key, required this.orderHistoryList, required this.inStorage, required this.orderQueueList, required this.orderList});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "In Queue",
            value: orderQueueList!.length.toString(),
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: width / 64,
          ),
          InfoCardSmall(
            title: "In Storage",
            value: inStorage!.length.toString(),
            onTap: () {},
          ),
          SizedBox(
            height: width / 64,
          ),
          InfoCardSmall(
            title: "Completed",
            value: orderHistoryList!.length.toString(),
            onTap: () {},
          ),
          SizedBox(
            height: width / 64,
          ),
          InfoCardSmall(
            title: "Total Order",
            value: orderList!.length.toString(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
