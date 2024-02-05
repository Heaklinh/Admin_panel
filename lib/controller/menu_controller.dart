import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/pages/routing/routes.dart';
import 'package:flutter/material.dart';

class MenuController {
  var activeItem = DashBoardPageRoute;
  var hoverItem = "";

  changeActiveItem(String itemName) {
    activeItem = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) {
      hoverItem = itemName;
    }
  }

  isActive(String itemName) => activeItem == itemName;
  isHover(String itemName) => hoverItem == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case DashBoardPageRoute:
        return _customIcon(Icons.widgets, itemName);
      case DrinkPageRoute:
        return _customIcon(Icons.free_breakfast, itemName);
      case SettingPageRoute:
        return _customIcon(Icons.settings, itemName);
      case AuthenthicationPageRoute:
        return _customIcon(Icons.logout, itemName);
      default:
        return _customIcon(Icons.logout, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) {
      return Icon(
        icon,
        size: 22,
        color: AppColor.secondary,
      );
    }

    return Icon(
      icon,
      color: isHover(itemName) ? Colors.grey[800] : Colors.grey[400],
    );
  }
}
