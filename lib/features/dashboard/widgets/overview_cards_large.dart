import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/features/dashboard/widgets/info_cart.dart';
import 'package:flutter/material.dart';

class OverviewCardLargeScreen extends StatelessWidget {
  final List<Order>? orderHistoryList;
  final List<Order>? inStorage;
  final List<Order>? orderQueueList;
  final List<Order>? orderList;
  const OverviewCardLargeScreen({super.key, required this.orderHistoryList,required this.inStorage, required this.orderQueueList, required this.orderList});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        InfoCard(
          title: "In Queue",
          value: orderQueueList!.length.toString(),
          topColor: Colors.orange,
          onTap: () {},
        ),
        SizedBox(
          width: width / 64,
        ),
        InfoCard(
          title: "In Storage",
          value: inStorage!.length.toString(),
          topColor: Colors.green,
          onTap: () {},
        ),
        SizedBox(
          width: width / 64,
        ),
        InfoCard(
          title: "Completed",
          value: orderHistoryList!.length.toString(),
          topColor: Colors.yellow,
          onTap: () {},
        ),
        SizedBox(
          width: width / 64,
        ),
        InfoCard(
          title: "Total Order",
          value: orderList!.length.toString(),
          topColor: Colors.blue,
          onTap: () {},
        ),
      ],
    );
  }
}
