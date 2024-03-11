import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/pages/dashboard/dashboard.dart';
import 'package:admin_panel/pages/drink/manage_drink.dart';
import 'package:admin_panel/pages/feedback/feedback.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/orders/current_order_screen.dart';
import 'package:admin_panel/pages/orders/order.dart';
import 'package:admin_panel/pages/widgets/top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_navigation/side_navigation.dart';

class DrawerState extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isSidebarOpen = false; // Track if sidebar is open

  int get selectedIndex => _selectedIndex;
  bool get isToggle => _isSidebarOpen;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  set isSideBarOpen(bool isToggle) {
    _isSidebarOpen = isToggle;
    notifyListeners();
  }
}

class DrawerItem {
  final String text;
  final Icon icon;

  DrawerItem({required this.text, required this.icon});
}

class SideBar extends StatefulWidget {
  static const String routeName = '/side_bar_nav';

  const SideBar({super.key});
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int selectedIndex = 0;

  List<Widget> pages = [
    const AdminDashboard(),
    const ManageDrink(),
    const CurrentOrderPage(),
    const FeedbackPage(),
    const Center(
      child: Text('Setting'),
    ),
    const Center(
      child: Text('Logout'),
    ),
  ];

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
      text: 'Current Orders',
      icon: const Icon(Icons.shopping_cart),
    ),
    DrawerItem(
      text: 'Feeback',
      icon: const Icon(Icons.feedback),
    ),
    DrawerItem(
      text: 'Settings',
      icon: const Icon(Icons.settings),
    ),
    DrawerItem(text: 'Logout', icon: const Icon(Icons.logout))
  ];

  void updatePage(int page) {
    setState(() {
      selectedIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrawerState(),
      builder: ((context, child) {
        final drawerState = Provider.of<DrawerState>(context);
        return Scaffold(
          key: scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar: topNavigationBar(context, scaffoldKey, drawerState),
          drawer: Container(
            color: AppColor.white,
            child: SideNavigationBar(
              expandable: false,
              header: const SideNavigationBarHeader(
                  image: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text('Admin'),
                  subtitle: Text('email@gmail.com')),
              selectedIndex: drawerState._selectedIndex,
              items: const [
                SideNavigationBarItem(
                  icon: Icons.home,
                  label: 'Home',
                ),
                SideNavigationBarItem(
                  icon: Icons.free_breakfast,
                  label: 'Drinks',
                ),
                SideNavigationBarItem(
                  icon: Icons.shopping_cart,
                  label: 'Incoming Orders',
                ),
                SideNavigationBarItem(
                  icon: Icons.feedback,
                  label: 'Feedback',
                ),
                SideNavigationBarItem(
                  icon: Icons.settings,
                  label: 'Setting',
                ),
                SideNavigationBarItem(
                  icon: Icons.logout,
                  label: 'Logout',
                ),
              ],
              theme: SideNavigationBarTheme(
                togglerTheme: SideNavigationBarTogglerTheme.standard(),
                itemTheme: SideNavigationBarItemTheme(
                    selectedItemColor: AppColor.primary),
                dividerTheme: SideNavigationBarDividerTheme.standard(),
              ),
              onTap: (index) {
                setState(() {
                  drawerState._selectedIndex = index;
                  Navigator.pop(context);
                });
              },
            ),
          ),
          body: Consumer<DrawerState>(builder: (context, drawerState, _) {
            return ResponsiveWidget(
              largeScreen: Row(
                children: [
                  Expanded(
                    child: Scaffold(
                      body: Row(
                        children: [
                          SideNavigationBar(
                            selectedIndex: drawerState._selectedIndex,
                            items: const [
                              SideNavigationBarItem(
                                icon: Icons.home,
                                label: 'Home',
                              ),
                              SideNavigationBarItem(
                                icon: Icons.free_breakfast,
                                label: 'Drinks',
                              ),
                              SideNavigationBarItem(
                                icon: Icons.shopping_cart,
                                label: 'Incoming Orders',
                              ),
                              SideNavigationBarItem(
                                icon: Icons.feedback,
                                label: 'Feedback',
                              ),
                              SideNavigationBarItem(
                                icon: Icons.settings,
                                label: 'Setting',
                              ),
                              SideNavigationBarItem(
                                icon: Icons.logout,
                                label: 'Logout',
                              ),
                            ],
                            theme: SideNavigationBarTheme(
                              togglerTheme:
                                  SideNavigationBarTogglerTheme.standard(),
                              itemTheme: SideNavigationBarItemTheme(
                                  selectedItemColor: AppColor.primary),
                              dividerTheme:
                                  SideNavigationBarDividerTheme.standard(),
                            ),
                            onTap: (index) {
                              setState(() {
                                drawerState._selectedIndex = index;
                              });
                            },
                            toggler: SideBarToggler(
                              expandIcon: Icons.keyboard_arrow_left,
                              shrinkIcon: Icons.keyboard_arrow_right,
                            ),
                          ),
                          Expanded(
                            child: pages.elementAt(drawerState._selectedIndex),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              mediumScreen: Row(
                children: [
                  Expanded(
                    child: Scaffold(
                      body: Row(
                        children: [
                          SideNavigationBar(
                            selectedIndex: drawerState._selectedIndex,
                            items: const [
                              SideNavigationBarItem(
                                icon: Icons.home,
                                label: 'Home',
                              ),
                              SideNavigationBarItem(
                                icon: Icons.free_breakfast,
                                label: 'Drinks',
                              ),
                              SideNavigationBarItem(
                                icon: Icons.shopping_cart,
                                label: 'Current Orders',
                              ),
                              SideNavigationBarItem(
                                icon: Icons.feedback,
                                label: 'Feedback',
                              ),
                              SideNavigationBarItem(
                                icon: Icons.settings,
                                label: 'Setting',
                              ),
                              SideNavigationBarItem(
                                icon: Icons.logout,
                                label: 'Logout',
                              ),
                            ],
                            theme: SideNavigationBarTheme(
                              togglerTheme:
                                  SideNavigationBarTogglerTheme.standard(),
                              itemTheme: SideNavigationBarItemTheme(
                                  selectedItemColor: AppColor.white,
                                  selectedBackgroundColor: AppColor.primary),
                              dividerTheme:
                                  SideNavigationBarDividerTheme.standard(),
                            ),
                            onTap: (index) {
                              setState(() {
                                drawerState._selectedIndex = index;
                              });
                            },
                            toggler: SideBarToggler(
                              expandIcon: Icons.arrow_forward_ios_rounded,
                              shrinkIcon: Icons.arrow_back_ios_rounded,
                              onToggle: () {
                               
                                drawerState._isSidebarOpen =
                                    !drawerState._isSidebarOpen;
                              },
                            ),
                          ),
                          Expanded(
                            child: pages.elementAt(drawerState._selectedIndex),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              smallScreen: pages[drawerState._selectedIndex],
            );
          }),
        );
      }),
    );
  }
}

// class DrawerItem {
//   final String text;
//   final Icon icon;

//   DrawerItem({required this.text, required this.icon});
// }

// class DrawerState extends ChangeNotifier {
//   int _selectedIndex = 0;

//   int get selectedIndex => _selectedIndex;

//   set selectedIndex(int index) {
//     _selectedIndex = index;
//     notifyListeners();
//   }
// }

// class SideBarItem extends StatefulWidget {
//   SideBarItem({
//     super.key,
//   });

//   final List<DrawerItem> drawerItems = [
//     DrawerItem(
//       text: 'Home',
//       icon: const Icon(Icons.home),
//     ),
//     DrawerItem(
//       text: 'Drink',
//       icon: const Icon(Icons.free_breakfast),
//     ),
//     DrawerItem(
//       text: 'Current Orders',
//       icon: const Icon(Icons.shopping_cart),
//     ),
//     DrawerItem(
//       text: 'Setting',
//       icon: const Icon(Icons.settings),
//     ),
//     DrawerItem(
//       text: 'Logout',
//       icon: const Icon(Icons.logout),
//     ),
//   ];

//   final List<Widget> _widgetOptions = [
//     const Text('Index 0'),
//     const ManageDrink(),
//     const CurrentOrderScreen(),
//     const Text(
//       'Index 2: School',
//       style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//     ),
//     const Text('Index 3'),
//   ];

//   @override
//   State<SideBarItem> createState() => _SideBarItemState();
// }

// class _SideBarItemState extends State<SideBarItem> {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => DrawerState(),
//       builder: (context, child) {
//         final drawerState = Provider.of<DrawerState>(context);
//         return Column(
//           children: [
//             if (ResponsiveWidget.isSmallScreen(context))
//               const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: 40,
//                   ),
//                   Expanded(
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 24,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(right: 12),
//                           child: Icon(Icons.abc),
//                         ),
//                         Flexible(
//                           child: CustomText(
//                               text: "Robot Cafe",
//                               size: 24,
//                               color: AppColor.secondary,
//                               weight: FontWeight.bold),
//                         ),
//                         SizedBox(width: 24),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             const Divider(),
//             Expanded(
//               child: SingleChildScrollView( // Wrap with SingleChildScrollView
//                 child: ListView.builder(
//                   shrinkWrap: true, // Add shrinkWrap property
//                   itemCount: widget.drawerItems.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       leading: widget.drawerItems[index].icon,
//                       title: Text(widget.drawerItems[index].text),
//                       onTap: () {
//                         // Update the state of the app
//                         widget._widgetOptions[drawerState.selectedIndex];
//                         // Then close the drawer
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ),

//           ],
//         );
//       },
//     );
//   }
// }
