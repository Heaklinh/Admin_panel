import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class InfoCardSmall extends StatelessWidget {
  final String title;
  final String value;
  final bool isActive;
  final VoidCallback onTap;
  const InfoCardSmall(
      {super.key,
      required this.title,
      required this.value,
      this.isActive = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isActive ? AppColor.primary : Colors.grey[400]!,
              width: .5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              size: 18,
              color: isActive ? AppColor.secondary : AppColor.disable,
              weight: FontWeight.normal,
            ),
            CustomText(
              text: value,
              size: 18,
              color: isActive ? AppColor.secondary : AppColor.disable,
              weight: FontWeight.bold,
            )
          ],
        ),
      ),
    ));
  }
}
