import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/pages/drink/widgets/card_large_screen.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/pages/widgets/side_bar.dart';
import 'package:flutter/material.dart';

class ManageDrink extends StatefulWidget {
  static const routeName = "/manage_drink";
  const ManageDrink({super.key});

  @override
  State<ManageDrink> createState() => _ManageDrinkState();
}

class _ManageDrinkState extends State<ManageDrink> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
              child: CustomText(
                text: menuController.activeItem,
                size: 24,
                color: AppColor.secondary,
                weight: FontWeight.bold,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        const Expanded(
          child: CardLargeScreen(),
        )
      ],
    );
  }
}
