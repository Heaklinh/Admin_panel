import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/pages/dashboard/dashboard.dart';
import 'package:admin_panel/pages/drink/manage_drink.dart';
import 'package:admin_panel/pages/feedback/feedback.dart';
import 'package:admin_panel/pages/orders/current_order_screen.dart';
import 'package:admin_panel/pages/setting/settings.dart';
import 'package:admin_panel/pages/user/manage_user_screen.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/pages/widgets/top_nav_bar.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

class SideBar extends StatefulWidget {
  static const String routeName = '/side_bar_nav';

  const SideBar({super.key});
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {

  AdminServices adminServices = AdminServices();

  int selectedIndex = 0;

  List<Widget> pages = [
    const AdminDashboard(),
    const ManageDrink(),
    const CurrentOrderPage(),
    const ManageUserPage(),
    const FeedbackPage(),
    const SettingPage()
  ];

  void updatePage(int page) {
    setState(() {
      selectedIndex = page;
    });
  }

  void logout(){
    adminServices.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context),
      body: Row(
        children: [
          SideNavigationBar(
            header: SideNavigationBarHeader(
              image: Image.asset(
                "assets/images/Robot Cafe Logo.png",
                width: 50,
              ),
              title: const CustomText(
                text: "Robot Cafe",
                size: 20,
                color: AppColor.primary,
                weight: FontWeight.bold,
              ),
              subtitle: const CustomText(
                text: "Welcome to robot cafe admin panel",
                size: 14,
                color: AppColor.secondary,
                weight: FontWeight.w200,
              ),
            ),
            selectedIndex: selectedIndex,
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
                icon: Icons.manage_accounts,
                label: 'Users',
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
                  const SideNavigationBarDividerTheme(
                    showHeaderDivider: true,
                    showMainDivider: true,
                    showFooterDivider: false,
                    mainDividerColor: Colors.black12,
                    mainDividerThickness: 2
                  ),
            ),
            onTap: (index) async {
              if (index == 6) {
                bool confirmLogout = await confirm(
                  context, 
                  title: const Text('Logout'), 
                  content:const Text('Are you sure you want to log out?')
                );
                if (confirmLogout) {
                  logout();
                }
              } else {
                setState(() {
                  selectedIndex = index;
                });
              }
            },
            toggler: const SideBarToggler(
              expandIcon: Icons.keyboard_arrow_left,
              shrinkIcon: Icons.keyboard_arrow_right,
            ),
          ),
          Expanded(
            child: pages.elementAt(selectedIndex),
          )
        ],
      ),
    );
  }
}