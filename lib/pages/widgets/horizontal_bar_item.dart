import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/constants/controller.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class HorizontalBarItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;
  const HorizontalBarItem({
    super.key,
    required this.itemName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.isHover(itemName)
            : menuController.isHover("not hovering");
      },
      child: Container(
        color: menuController.isHover(itemName)
            ? Colors.grey[400]
            : Colors.transparent,
        child: Row(
          children: [
            Visibility(
              visible: menuController.isHover(itemName) ||
                  menuController.isActive(itemName),
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: Container(
                width: 6,
                height: 40,
                color: AppColor.secondary,
              ),
            ),
            SizedBox(
              width: width / 80,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: menuController.returnIconFor(itemName),
            ),
            if (!menuController.isActive(itemName))
              Flexible(
                child: CustomText(
                  text: itemName,
                  size: 18,
                  color: menuController.isHover(itemName)
                      ? AppColor.secondary
                      : AppColor.white,
                  weight: FontWeight.bold,
                ),
              )
            else
              Flexible(
                child: CustomText(
                  text: itemName,
                  size: 18,
                  color: AppColor.secondary,
                  weight: FontWeight.bold,
                ),
              )
          ],
        ),
      ),
    );
  }
}
