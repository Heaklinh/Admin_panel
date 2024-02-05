import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/horizontal_bar_item.dart';
import 'package:admin_panel/pages/widgets/vertical_bar_item.dart';

import 'package:flutter/material.dart';

class SideBarItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;
  const SideBarItem({
    super.key,
    required this.itemName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomScreen(context)) {
      return VerticalBarItem(itemName: itemName, onTap: onTap);
    }
    return HorizontalBarItem(itemName: itemName, onTap: onTap);
  }
}
