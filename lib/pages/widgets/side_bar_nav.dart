import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/layout.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerItem {
  final String text;
  final Icon icon;

  DrawerItem({required this.text, required this.icon});
}

class DrawerState extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

class SideBarItem extends StatefulWidget {
  SideBarItem({
    super.key,
  });

  final List<DrawerItem> drawerItems = [
    DrawerItem(
      text: 'Home',
      icon: Icon(Icons.home),
    ),
    DrawerItem(
      text: 'Drink',
      icon: Icon(Icons.free_breakfast),
    ),
    DrawerItem(
      text: 'Setting',
      icon: Icon(Icons.settings),
    ),
    DrawerItem(
      text: 'Logout',
      icon: Icon(Icons.logout),
    ),
  ];

  final List<Widget> _widgetOptions = [
    Text('Index 0'),
    Text(
      'Index 1: Business',
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text(
      'Index 2: School',
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text('Index 3'),
  ];

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrawerState(),
      builder: (context, child) {
        final drawerState = Provider.of<DrawerState>(context);

        return Column(
          children: [
            if (ResponsiveWidget.isSmallScreen(context)) 
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 24,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(Icons.abc),
                        ),
                        Flexible(
                          child: CustomText(
                              text: "Robot Cafe",
                              size: 24,
                              color: AppColor.secondary,
                              weight: FontWeight.bold),
                        ),
                        const SizedBox(width: 24),
                      ],
                    ),
                  )
                ],
              ),
            const Divider(),
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.drawerItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: widget.drawerItems[index].icon,
                  title: Text(widget.drawerItems[index].text),
                  onTap: () {
                    // Update the state of the app
                    widget._widgetOptions[drawerState.selectedIndex];
                    // Then close the drawer
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
