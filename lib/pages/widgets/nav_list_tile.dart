import 'package:admin_panel/constants/color.dart';
import 'package:flutter/material.dart';

class NavListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  const NavListTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: AppColor.primary,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColor.primary,
          fontSize: 18,
        ),
      ),
    );
  }
}
