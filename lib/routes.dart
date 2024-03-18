
import 'package:admin_panel/pages/auth/authenthication.dart';
import 'package:admin_panel/pages/widgets/side_bar_nav.dart';
import 'package:admin_panel/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const rootRoute = '/';

Route<dynamic> generateRoute(BuildContext context, RouteSettings routeSettings) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  if(userProvider.user.loginToken.isNotEmpty && userProvider.user.type == 'admin'){
    switch (routeSettings.name) {
      case SideBar.routeName:
        return MaterialPageRoute(
          settings: routeSettings, 
          builder: (_) => const SideBar(),
        );
      case AuthenticationPage.routeName:
        return MaterialPageRoute(
          settings: routeSettings, 
          builder: (_) => const AuthenticationPage(),
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
  } else {
    return MaterialPageRoute(
      settings: routeSettings, 
      builder: (_) => const AuthenticationPage(),
    );
  }
}
