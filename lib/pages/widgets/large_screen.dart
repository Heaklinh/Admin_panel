import 'package:admin_panel/pages/drink/manage_drink.dart';
import 'package:admin_panel/pages/widgets/side_bar.dart';
import 'package:admin_panel/pages/widgets/side_bar_nav.dart';
import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SideBarItem(),
        ),
        Expanded(
          flex: 5,
          child: ManageDrink(),
        ),
      ],
    );
  }
}
