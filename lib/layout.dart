import 'package:admin_panel/pages/drink/manage_drink.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/large_screen.dart';
import 'package:admin_panel/pages/widgets/top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerState extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class DrawerItem {
  final String text;
  final Icon icon;

  DrawerItem({required this.text, required this.icon});
}

class SiteLayout extends StatefulWidget {
  const SiteLayout({super.key, required this.title});
  final String title;
  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<DrawerItem> drawerItems = [
    DrawerItem(
      text: 'Home',
      icon: const Icon(Icons.home),
    ),
    DrawerItem(
      text: 'Drink',
      icon: const Icon(Icons.free_breakfast),
    ),
    DrawerItem(
      text: 'Setting',
      icon: const Icon(Icons.settings),
    ),
    DrawerItem(
      text: 'Logout',
      icon: const Icon(Icons.logout),
    ),
  ];
  final List<Widget> _widgetOptions = <Widget>[
    Text('Index 0'),
    const ManageDrink(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text('Index 3')
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrawerState(),
      builder: ((context, child) {
        final drawerState = Provider.of<DrawerState>(context);
        return Scaffold(
          key: scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar: topNavigationBar(context, scaffoldKey),
          drawer: Drawer(
            child: SideBarItem(drawerItems: drawerItems, drawerState: drawerState),
          ),
          body: Consumer<DrawerState>(
            builder: (context, drawerState, _) {
              return ResponsiveWidget(
                largeScreen: const LargeScreen(),
                smallScreen: _widgetOptions[drawerState.selectedIndex],
                mediumScreen: const LargeScreen(),
              );
            },
          ),
        );
      }),
    );
  }
}

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    super.key,
    required this.drawerItems,
    required this.drawerState,
  });

  final List<DrawerItem> drawerItems;
  final DrawerState drawerState;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: drawerItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: drawerItems[index].icon,
          title: Text(drawerItems[index].text),
          onTap: () {
            // Update the state of the app
            drawerState.selectedIndex = index;
            // Then close the drawer
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
