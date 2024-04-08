import 'package:admin_panel/constants/color.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color topColor;
  final bool isActive;
  final VoidCallback onTap;
  const InfoCard(
      {super.key,
      required this.title,
      required this.value,
      required this.topColor,
      this.isActive = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 136,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 6),
                  color: Colors.grey[400]!.withOpacity(.1),
                  blurRadius: 12,
                ),
              ],
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: topColor,
                      height: 5,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$title\n",
                      style: TextStyle(
                        fontSize: 16,
                        color: isActive ? AppColor.primary : Colors.grey[400],
                      ),
                    ),
                    TextSpan(
                      text: "$value\n",
                      style: TextStyle(
                        fontSize: 40,
                        color: isActive ? AppColor.primary : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
