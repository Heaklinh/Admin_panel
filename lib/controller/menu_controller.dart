import 'package:flutter/material.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/pages/routing/routes.dart';

class MenuController extends ChangeNotifier {
  String _activeItem = drinkPageRoute;
  String _hoverItem = "";

  String get activeItem => _activeItem;

  set activeItem(String itemName) {
    _activeItem = itemName;
    notifyListeners();
  }

  String get hoverItem => _hoverItem;

  set hoverItem(String itemName) {
    _hoverItem = itemName;
    notifyListeners();
  }

  bool isActive(String itemName) => _activeItem == itemName;
  bool isHover(String itemName) => _hoverItem == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case dashBoardPageRoute:
        return _customIcon(Icons.widgets, itemName);
      case drinkPageRoute:
        return _customIcon(Icons.free_breakfast, itemName);
      case settingPageRoute:
        return _customIcon(Icons.settings, itemName);
      case authenthicationPageRoute:
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

class SideBarState extends ChangeNotifier {
  String itemName = '';

  String get activeItem => itemName;
  String get hoverItem => itemName;

  set activeItem(String item) {
    itemName = item;
    notifyListeners();
  }

  set hoverItem(String item) {
    itemName = item;
    notifyListeners();
  }

  bool isActive(String itemName) => activeItem == itemName;
  bool isHover(String itemName) => hoverItem == itemName;
}
