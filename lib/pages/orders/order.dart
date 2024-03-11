import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/orders/widgets/item_tile.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:flutter/material.dart';

class CurrentOrderScreen extends StatefulWidget {
  static const routeName = "/order";
  const CurrentOrderScreen({super.key});

  @override
  State<CurrentOrderScreen> createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
  final TextEditingController textController = TextEditingController();

  List<Order>? orders;
  List<Product>? productList;
  List<User>? userList;
  final AdminServices adminServices = AdminServices();

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

  fetchAllUsers() async {
    userList = await adminServices.fetchAllUsers(context);
    setState(() {});
  }

  fetchAllOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  String getOrderStatusText(int status, int queue) {
    queue = queue + 1;
    String statusText = "";
    if (status == 0) {
      statusText = "Waiting";
    } else if (status == 1) {
      statusText = "Queue: $queue";
    } else if (status == 2) {
      statusText = "Preparing";
    } else if (status == 3) {
      statusText = "Ready to Pick Up";
    } else {
      statusText = "Done";
    }
    return statusText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // fit: FlexFit.tight,
          // // padding: const EdgeInsets.all(16),
          // child: Container(
          //   decoration: BoxDecoration(
          //     color: AppColor.white,
          //     borderRadius: BorderRadius.circular(8),
          //     boxShadow: [
          //       BoxShadow(
          //         offset: const Offset(0, 6),
          //         color: AppColor.disable.withOpacity(.1),
          //         blurRadius: 12,
          //       ),
          //     ],
          //     border: Border.all(
          //       color: AppColor.disable,
          //       width: .5,
          //     ),
          //   ),

          Positioned(
            top: ResponsiveWidget.isSmallScreen(context) ? 56 : 0,
            left: 0,
            right: 0,
            bottom: 0.0, // Adjust for widget height
            child: orders == null || productList == null || userList == null
                ? const Loader()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: orders!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Header if it's the first item
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                flex:
                                    ResponsiveWidget.isCustomScreen(context)
                                        ? 2
                                        : 3,
                                child: Text(
                                  "Order",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        ResponsiveWidget.isLargeScreen(
                                                context)
                                            ? 16
                                            : 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ResponsiveWidget.isSmallScreen(
                                        context)
                                    ? Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Price',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: ResponsiveWidget
                                                    .isLargeScreen(context)
                                                ? 16
                                                : 14,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        'Price',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: ResponsiveWidget
                                                  .isLargeScreen(context)
                                              ? 16
                                              : 14,
                                        ),
                                      ),
                              ),
                              Expanded(
                                child: Text(
                                  "User",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          ResponsiveWidget.isLargeScreen(
                                                  context)
                                              ? 16
                                              : 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "Status",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          ResponsiveWidget.isLargeScreen(
                                                  context)
                                              ? 16
                                              : 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      bool found = false;
                      bool foundUser = false;
                      final orderData = orders![index - 1];
                      // final matchingProduct = products!.firstWhere(
                      //   (product) => product.id == orderData.productID,
                      // );
                      late Product productFound;
                      for (int i = 0; i < productList!.length; i++) {
                        final products = productList![i];
                        if (products.id == orderData.productID) {
                          productFound = products;
                          found = true;
                          break;
                        }
                
                        found = false;
                      }
                
                      late User userFound;
                      for (int i = 0; i < userList!.length; i++) {
                        final users = userList![i];
                        if (users.id == orderData.userID) {
                          userFound = users;
                          break;
                        }
                      }
                      if (!foundUser) {
                        userFound = User(
                          id: orderData.userID,
                          name: 'Deleted User',
                          email: 'Deleted User',
                          password: 'Deleted User',
                          confirmPassword: 'Deleted User',
                          type: 'user',
                          loginToken: 'Deleted User',
                          verified: null,
                          createdAt: null,
                          lastRequestedOTP: null,
                          requestedOTPCount: 0,
                          feedback: ''
                        );
                      }
                
                      if (!found) {
                        productFound = Product(
                          id: orderData.productID,
                          name: 'Deleted Product',
                          price: 0,
                          description: 'Deleted Product',
                          image:
                              'https://res.cloudinary.com/dsx7eoho1/image/upload/v1708670880/Product/e4nbm5zqfq8cbkkvnat2.png',
                        );
                      }
                      if (orderData.status == 4) {
                        return const SizedBox.shrink();
                      }
                
                      return ItemTile(
                          image: productFound.image,
                          username: userFound.name,
                          price: productFound.price.toStringAsFixed(2),
                          status: getOrderStatusText(
                              orderData.status, orderData.queue),
                          orderNumber: orderData.orderNumber,
                          productName: productFound.name);
                    }),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              color: AppColor.white,
              margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 0),
              child: const CustomText(
                text: "Incoming Orders",
                size: 24,
                color: AppColor.secondary,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
