// import 'package:admin_panel/constants/color.dart';
// import 'package:admin_panel/pages/helpers/responsiveness.dart';
// import 'package:admin_panel/pages/routing/routes.dart';
// import 'package:admin_panel/pages/widgets/custom_text.dart';
// import 'package:admin_panel/pages/widgets/side_bar_item.dart';
// import 'package:flutter/material.dart';
// import 'package:admin_panel/controller/menu_controller.dart' as admin_panel_bar;
// import 'package:provider/provider.dart';

// admin_panel_bar.MenuController menuController =
//     admin_panel_bar.MenuController();

// class SideBar extends StatelessWidget {
//   const SideBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //double width = MediaQuery.of(context).size.width;
//     return ChangeNotifierProvider(
//       create: (_) => menuController,
//       builder: (context, child) {
//         return Container(
//           color: AppColor.white,
//           child: ListView(
//             children: [
//               if (ResponsiveWidget.isSmallScreen(context))
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           const SizedBox(
//                             width: 24,
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.only(right: 12),
//                             child: Icon(Icons.abc),
//                           ),
//                           Flexible(
//                             child: CustomText(
//                                 text: "Robot Cafe",
//                                 size: 24,
//                                 color: AppColor.secondary,
//                                 weight: FontWeight.bold),
//                           ),
//                           const SizedBox(width: 24),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               Divider(
//                 color: AppColor.disable.withOpacity(0.3),
//               ),
//               Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: sideBarItems
//                     .map(
//                       (itemName) => SideBarItem(
//                         itemName: itemName == authenthicationPageRoute
//                             ? "Logout"
//                             : itemName,
//                         onTap: () {
//                           if (itemName == authenthicationPageRoute) {
//                             // TO DO: Go to auth page
//                           }
//                           if (!menuController.isActive(itemName)) {
//                             menuController.activeItem;
//                             if (ResponsiveWidget.isSmallScreen(context)) {
//                               Navigator.pop(context);
//                               // TO DO: Go to item name route
//                             }
//                           }
//                         },
//                       ),
//                     )
//                     .toList(),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
