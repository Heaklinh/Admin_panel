import 'package:admin_panel/pages/drink/manage_drink.dart';
import 'package:admin_panel/pages/widgets/side_bar_nav.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SideBarItem(),
        ),
        const Expanded(
          flex: 5,
          child: ManageDrink(),
        ),
      ],
    );
  }
}
