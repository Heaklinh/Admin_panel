
import 'package:admin_panel/pages/drink/manage_drink.dart';
import 'package:admin_panel/pages/drink/widgets/card_large_screen.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
              // child: CustomText(
              //   text: menuController.activeItem,
              //   size: 24,
              //   color: AppColor.secondary,
              //   weight: FontWeight.bold,
              // ),
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        // const Expanded(
        //   child: CardLargeScreen(),
        // )
        const Expanded(
          child: ManageDrink(),
        )
      ],
    );
  }
}
