import 'package:admin_panel/pages/auth/authenthication.dart';
import 'package:admin_panel/pages/dashboard/dashboard.dart';
import 'package:admin_panel/pages/drink/add_product_page.dart';
import 'package:admin_panel/pages/drink/manage_drink.dart';
import 'package:admin_panel/pages/feedback/feedback.dart';
import 'package:admin_panel/pages/orders/current_order_screen.dart';
import 'package:admin_panel/pages/orders/order.dart';
import 'package:admin_panel/pages/widgets/side_bar_nav.dart';
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
    case SideBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings, 
        builder: (_) => const SideBar(),
      );
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
    case CurrentOrderPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings, 
        builder: (_) => const CurrentOrderPage(),
      );
    case AdminDashboard.routeName:
      return MaterialPageRoute(
        settings: routeSettings, 
        builder: (_) => const AdminDashboard(),
      );
    case AuthenticationPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings, 
        builder: (_) => const AuthenticationPage(),
      );
    case FeedbackPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings, 
        builder: (_) => const FeedbackPage(),
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
