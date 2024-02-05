import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/constants/controller.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class VerticalBarItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;
  const VerticalBarItem(
      {super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover("not hovering");
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
                width: 3,
                height: 64,
                color: AppColor.secondary,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                          weight: FontWeight.bold),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
