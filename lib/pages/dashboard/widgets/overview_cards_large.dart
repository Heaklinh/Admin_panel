import 'package:admin_panel/pages/dashboard/widgets/info_cart.dart';
import 'package:flutter/material.dart';

class OverviewCardLargeScreen extends StatelessWidget {
  const OverviewCardLargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        InfoCard(
          title: "In Queue",
          value: "7",
          topColor: Colors.orange,
          onTap: () {},
        ),
        SizedBox(
          width: width / 64,
        ),
        InfoCard(
          title: "In Storage",
          value: "7",
          topColor: Colors.green,
          onTap: () {},
        ),
        SizedBox(
          width: width / 64,
        ),
        InfoCard(
          title: "Completed",
          value: "7",
          topColor: Colors.yellow,
          onTap: () {},
        ),
        SizedBox(
          width: width / 64,
        ),
        InfoCard(
          title: "Total Order",
          value: "7",
          topColor: Colors.blue,
          onTap: () {},
        ),
      ],
    );
  }
}
