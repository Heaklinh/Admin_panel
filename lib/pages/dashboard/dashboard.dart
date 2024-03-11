import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/pages/dashboard/widgets/order_history.dart';
import 'package:admin_panel/pages/dashboard/widgets/overview_cards_large.dart';
import 'package:admin_panel/pages/dashboard/widgets/overview_cards_medium.dart';
import 'package:admin_panel/pages/dashboard/widgets/overview_cards_small.dart';
import 'package:admin_panel/pages/dashboard/widgets/revenue_info_section_large.dart';
import 'package:admin_panel/pages/dashboard/widgets/revenue_info_section_small.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  static const String routeName = '/dashboard';
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  
  List<Order>? orderList;
  List<Product>? productList;
  List<User>? userList;
  List<Order>? orderHistoryList;
  List<Order>? orderQueueList;
  List<Order>? inStorage;

  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
    fetchAllProducts();
    fetchAllUsers();
  }

  fetchAllProducts() async {
    productList = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  fetchAllUsers() async{
    userList = await adminServices.fetchAllUsers(context);
    setState(() {});
  }
  
  fetchAllOrders() async {
    orderList = await adminServices.fetchAllOrders(context);
    categorizeOrders(orderList); // Call getOrderStatus when fetching orders
    setState(() {});
  }

  // Function to categorize orders based on their status
  void categorizeOrders(List<Order>? orders) {
    orderQueueList = [];
    inStorage = [];
    orderHistoryList = [];

    if (orders != null) {
      for (int i = 0; i < orders.length; i++) {
        int status = orders[i].status;
        if (status <= 2) {
          orderQueueList!.add(orders[i]);
        } else if (status == 3) {
          inStorage!.add(orders[i]);
        } else {
          orderHistoryList!.add(orders[i]);
        }
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return orderList == null || productList == null || userList == null
      ? const Loader()
      : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 56 : 0),
                child: const CustomText(
                  text: "Overview",
                  size: 24,
                  color: AppColor.secondary,
                  weight: FontWeight.bold,
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                if (ResponsiveWidget.isLargeScreen(context) ||
                    ResponsiveWidget.isMediumScreen(context))
                  if (ResponsiveWidget.isCustomScreen(context))
                    OverviewCardMediumScreen(
                      orderQueueList: orderQueueList, 
                      inStorage: inStorage, 
                      orderHistoryList: 
                      orderHistoryList, 
                      orderList: orderList
                    )
                  else
                    OverviewCardLargeScreen(
                      orderQueueList: orderQueueList, 
                      inStorage: inStorage, 
                      orderHistoryList: orderHistoryList, 
                      orderList: orderList
                    )
                else
                  OverviewCardSmallScreen(
                    orderQueueList: orderQueueList, 
                    inStorage: inStorage, 
                    orderHistoryList: orderHistoryList, 
                    orderList: orderList
                  ),
                if (ResponsiveWidget.isSmallScreen(context))
                  const RevenueSectionSmall()
                else
                  RevenueSectionLarge(orderList: orderList),
                OrderHistory(orderHistoryList: orderHistoryList, productList: productList, userList: userList)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
