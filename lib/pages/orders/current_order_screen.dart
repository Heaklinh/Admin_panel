import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/pages/drink/widgets/custom_text_input.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/orders/widgets/drop_down.dart';
import 'package:admin_panel/pages/orders/widgets/item_tile.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CurrentOrderPage extends StatefulWidget {
  static const routeName = "/current_order_screen";
  const CurrentOrderPage({super.key});

  @override
  State<CurrentOrderPage> createState() => _CurrentOrderPageState();
}

class _CurrentOrderPageState extends State<CurrentOrderPage> {
  final TextEditingController textController = TextEditingController();

  List<Order>? orders;
  List<Product>? productList;
  List<User>? userList;
  final AdminServices adminServices = AdminServices();

  final List<String> sortItems = [
    'Ascending',
    'Descending',
  ];

  String? selectedValue;
  bool isOrderDescending = false;
  bool isUsernameDescending = false;

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
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
            child: const CustomText(
              text: "Incoming Orders",
              size: 24,
              color: AppColor.secondary,
              weight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomDropdownButton2(
                buttonHeight: 50,
                hint: "Sort by order",
                value: selectedValue,
                dropdownItems: sortItems,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                    isOrderDescending = !isOrderDescending;
                  });
                },
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
              // CustomTextInput(
              //   onChanged:
              //   controller: textController,
              //   hintText: 'Search',
              //   icon: Icons.search,
              //   isSubmitted: false,
              // )
              Container(
                width: 300,
                child: TextFormField(
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      suffixIcon: const Icon(Icons.search)),
                ),
              )
            ],
          ),
          Expanded(
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
              child: orders == null || productList == null || userList == null
                  ? const Loader()
                  : CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            // expandedTitleScale: 1,
                            background: Container(
                              //color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              decoration: const BoxDecoration(
                                  color: AppColor.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black,
                                      width: 0.3,
                                    ),
                                  )),
                              child: Row(
                                // Header Row Content
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
                            ),
                          ),
                        ),
                        //Scrollable Widget
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: orders!.length, (context, index) {
                            bool found = false;
                            bool foundUser = false;
                            final sortedOrders = isOrderDescending
                                ? orders!.reversed.toList()
                                : orders;
                            final orderData = sortedOrders![index];
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
                        )
                      ],
                    )
              // : ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: orders!.length,
              //     itemBuilder: (context, index) {
              //       bool found = false;

              //       final orderData = orders![index];
              //       // final matchingProduct = products!.firstWhere(
              //       //   (product) => product.id == orderData.productID,
              //       // );
              //       late Product productFound;
              //       for (int i = 0; i < productList!.length; i++) {
              //         final products = productList![i];
              //         if (products.id == orderData.productID) {
              //           productFound = products;
              //           found = true;
              //           break;
              //         }

              //         found = false;
              //       }

              //       late User userFound;
              //       for (int i = 0; i < userList!.length; i++) {
              //         final users = userList![i];
              //         if (users.id == orderData.userID) {
              //           userFound = users;
              //           break;
              //         }
              //       }

              //       if (!found) {
              //         productFound = Product(
              //           id: orderData.productID,
              //           name: 'Deleted Product',
              //           price: 0,
              //           description: 'Deleted Product',
              //           image:
              //               'https://res.cloudinary.com/dsx7eoho1/image/upload/v1708670880/Product/e4nbm5zqfq8cbkkvnat2.png',
              //         );
              //       }
              //       if (orderData.status == 4) {
              //         return const SizedBox.shrink();
              //       }
              //       return Container(
              //         margin: const EdgeInsets.only(bottom: 8),
              //         decoration: BoxDecoration(
              //           color: AppColor.white,
              //           borderRadius: BorderRadius.circular(8),
              //           boxShadow: [
              //             BoxShadow(
              //               offset: const Offset(0, 6),
              //               color: AppColor.disable.withOpacity(.1),
              //               blurRadius: 12,
              //             ),
              //           ],
              //         ),
              //         child: InkWell(
              //           borderRadius: BorderRadius.circular(8),
              //           onTap: () {},
              //           child: Column(
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsets.symmetric(
              //                     horizontal: 18, vertical: 18),
              //                 child: Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Row(
              //                       children: [
              //                         Image.network(
              //                           productFound.image,
              //                           width: 50,
              //                           height: 50,
              //                           fit: BoxFit.cover,
              //                         ),
              //                         const SizedBox(
              //                           width: 10,
              //                         ),
              //                         Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           children: [
              //                             Text(
              //                               "Order Number: ${orderData.orderNumber}",
              //                               style: const TextStyle(
              //                                 fontFamily: "Niradei",
              //                                 fontWeight: FontWeight.bold,
              //                               ),
              //                             ),
              //                             Text(
              //                               productFound.name,
              //                               style: const TextStyle(
              //                                   fontFamily: "Niradei",
              //                                   fontSize: 11),
              //                             )
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                     Text('\$${productFound.price}'),
              //                     Text(userFound.name),
              //                     Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Container(
              //                           decoration: const ShapeDecoration(
              //                             color: AppColor.primary,
              //                             shape: BeveledRectangleBorder(
              //                               borderRadius: BorderRadius.only(
              //                                 bottomRight: Radius.circular(4),
              //                               ),
              //                             ),
              //                           ),
              //                           child: Container(
              //                             margin: const EdgeInsets.all(6),
              //                             child: Text(
              //                               getOrderStatusText(
              //                                   orderData.status,
              //                                   orderData.queue),
              //                               style: const TextStyle(
              //                                   color: AppColor.white),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //               ),
              //               // const DividerTheme(
              //               //   data: DividerThemeData(
              //               //     space: 0, // Set the spacing to zero
              //               //   ),
              //               //   child: Divider(),
              //               // ),
              //             ],
              //           ),
              //         ),
              //       );
              //     }),
              ),
        ],
      ),
    );
  }
}
