import 'package:admin_panel/pages/drink/add_product_page.dart';
import 'package:admin_panel/pages/drink/manage_drink.dart';
import 'package:flutter/material.dart';

const rootRoute = '/';

const dashBoardDisplayName = "DashBoard";
const dashBoardPageRoute = "dashBoard";

const drinkDisplayName = "Drink";
const drinkPageRoute = "drink";

const settingDisplayName = "Setting";
const settingPageRoute = "setting";
const authenthicationDispkay = "Authentication";
const authenthicationPageRoute = "Authentication";

List sideBarItems = [
  dashBoardPageRoute,
  drinkPageRoute,
  settingPageRoute,
  authenthicationPageRoute
];

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case ManageDrink.routeName:
      return MaterialPageRoute(
        settings: routeSettings, 
        builder: (_) => const ManageDrink(),
      );
    case AddProductPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings, 
        builder: (_) => AddProductPage(onProductAdded: () {}),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist'),
          ),
        ),
      );
  }
}
