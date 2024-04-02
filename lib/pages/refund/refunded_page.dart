import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/constants/waiting_dialog.dart';
import 'package:admin_panel/models/maintain_toggle.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/orders/widgets/drop_down.dart';
import 'package:admin_panel/pages/setting/services/setting_services.dart';
import 'package:admin_panel/pages/user/services/user_services.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class RefundedOrderPage extends StatefulWidget {
  const RefundedOrderPage({super.key});

  @override
  State<RefundedOrderPage> createState() => _RefundedOrderPageState();
}

class _RefundedOrderPageState extends State<RefundedOrderPage> {
  final TextEditingController textController = TextEditingController();

  List<Order>? orders;
  List<Product>? productList;
  List<User>? userList;
  MaintainToggle? maintainToggle;
  late Order orderData;

  final UserServices userServices = UserServices();
  final AdminServices adminServices = AdminServices();
  final SettingServices settingServices = SettingServices();
  
  fetchMaintainToggle() async {
    maintainToggle = await settingServices.fetchMaintainToggle(context: context, toggle: false);
    if(context.mounted){
      setState(() {});
    }
  }

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
    fetchMaintainToggle();
  }

  fetchAllProducts() async {
    productList = await adminServices.fetchAllProducts(context);
    if(context.mounted){
      setState(() {});
    }
  }

  fetchAllUsers() async {
    userList = await userServices.fetchAllUsers(context);
    if(context.mounted){
      setState(() {});
    }
  }

  fetchAllOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    if(context.mounted){
      setState(() {});
    }
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

  void handleOrderChanged() {
    fetchAllOrders();
  }

  Future<void> deleteOrder()async{
    await adminServices.deleteOrder(
      context: context,
      order: orderData,
      onSuccess: handleOrderChanged,
    );
    if(!context.mounted) return;
    Navigator.pop(context);
    showSnackBar(context, "Order deleted successfully");
  }

  Future<void> refundOrder()async{
    await adminServices.refundOrder(
      context: context,
      order: orderData,
      onSuccess: handleOrderChanged,
    );
    if(!context.mounted) return;
    Navigator.pop(context);
    showSnackBar(context, "Order refunded successfully");
  }

  @override
  Widget build(BuildContext context) {

    DataRow buildDataRow(Order order) {
      bool found = false;
      bool foundUser = false;

      late Product productFound;
      for (int i = 0; i < productList!.length; i++) {
        final products = productList![i];
        if (products.id == order.productID) {
          productFound = products;
          found = true;
          break;
        }

        found = false;
      }

      late User userFound;
      for (int i = 0; i < userList!.length; i++) {
        final users = userList![i];
        if (users.id == order.userID) {
          userFound = users;
          foundUser = true;
          break;
        }
        foundUser = false;
      }
      if (!foundUser) {
        userFound = User(
          id: order.userID,
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
          id: order.productID,
          name: 'Deleted Product',
          price: 0,
          description: 'Deleted Product',
          image:
              'https://res.cloudinary.com/dsx7eoho1/image/upload/v1708670880/Product/e4nbm5zqfq8cbkkvnat2.png',
        );
      }
      return DataRow(
        cells: [
          DataCell(
            Row(
              children: [
                Image.network(
                  productFound.image,
                  width: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order Number: ${order.orderNumber}",
                        style: const TextStyle(
                          fontFamily: "Niradei",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        productFound.name,
                        style: const TextStyle(
                            fontFamily: "Niradei", fontSize: 11),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          DataCell(
            Text(
              '\$${order.totalPrice}',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          DataCell(
            Text(
              userFound.name,
              style: const TextStyle(
                  fontSize: 14),
            ),
          ),
          DataCell(
            Container(
              decoration: const ShapeDecoration(
                color: AppColor.primary,
                shape: BeveledRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(4)),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(6),
                child: Text(
                  getOrderStatusText(order.status, order.queue),
                  style: const TextStyle(
                    color: AppColor.white,
                    fontSize: 14
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          DataCell(
            Text(
              order.isRefunded.toString(),
              style: const TextStyle(
                  fontSize: 14),
            ),
          ),
          DataCell(
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    bool confirmLogout = await confirm(
                      context, 
                      title: const Text('Delete'), 
                      content:const Text('Are you sure you want to delete this order?')
                    );
                    if (confirmLogout) {
                      orderData = order;
                      if(!context.mounted) return;
                      waitingDialog(context, deleteOrder, "Deleting Order...");
                    }
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    bool confirmLogout = await confirm(
                      context, 
                      title: const Text('Undo Refund Order'), 
                      content:const Text('Are you sure you want to undo refund this order?')
                    );
                    if (confirmLogout) {
                      orderData = order;
                      if(!context.mounted) return;
                      waitingDialog(context, refundOrder, "Undoing Refund Order...");
                    }
                  },
                  icon: const Icon(
                    Icons.monetization_on,
                  ),
                ),
              ],
            )
          ),
        ],
      );
    }

    if(maintainToggle == null || orders == null || productList == null || userList == null){
      return const Loader();
    }else{
      
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: const CustomText(
                    text: "Refund History",
                    size: 24,
                    color: AppColor.secondary,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              child: maintainToggle!.toggle == true
              ? Container(
                  color: Colors.red,
                  child: const CustomText(
                    text: "The server is currently under maintenance.",
                    size: 24,
                    color: Colors.white,
                    weight: FontWeight.bold,
                  ),
                )
              : const CustomText(
                text: "",
                size: 0,
                color: Colors.white,
                weight: FontWeight.bold,
              )
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView(
                primary: true,
                padding: const EdgeInsets.all(0),
                children: [
                  ResponsiveWidget.isSmallScreen(context) 
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomDropdownButton2(
                        buttonHeight: 50,
                        buttonWidth: 70,
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
                      
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          onFieldSubmitted: (value) async {
                            if(value.trim().isNotEmpty){
                              waitingDialog(context, ()async{
                                userList = await userServices.fetchSearchUser(context: context, searchQuery: value);
                                if (userList != null && userList!.isNotEmpty) {
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }
                              , "Searching User...");
                            }else{     
                              waitingDialog(context, () async {
                                orders = await adminServices.fetchAllOrders(context);
                                if(context.mounted){
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }, "Searching User...");
                              waitingDialog(context, () async {
                                productList = await adminServices.fetchAllProducts(context);
                                if(context.mounted){
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }, "Searching User...");
                              waitingDialog(context, () async {
                                userList = await userServices.fetchAllUsers(context);
                                if(context.mounted){
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }, "Searching User...");
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Search user",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              suffixIcon: const Icon(Icons.search)),
                        ),
                      ),
                    ]
                  )
                  : Row(
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
                      
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          onFieldSubmitted: (value) async {
                            if(value.trim().isNotEmpty){
                              waitingDialog(context, ()async{
                                userList = await userServices.fetchSearchUser(context: context, searchQuery: value);
                                if (userList != null && userList!.isNotEmpty) {
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }
                              , "Searching User...");
                            }else{     
                              waitingDialog(context, () async {
                                orders = await adminServices.fetchAllOrders(context);
                                if(context.mounted){
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }, "Searching User...");
                              waitingDialog(context, () async {
                                productList = await adminServices.fetchAllProducts(context);
                                if(context.mounted){
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }, "Searching User...");
                              waitingDialog(context, () async {
                                userList = await userServices.fetchAllUsers(context);
                                if(context.mounted){
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }, "Searching User...");
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Search user",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              suffixIcon: const Icon(Icons.search)),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    margin: const EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 6),
                          color: AppColor.disable.withOpacity(.1),
                          blurRadius: 12,
                        )
                      ],
                      border: Border.all(
                        color: AppColor.disable,
                        width: .5,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ResponsiveWidget.isSmallScreen(context) ? (56 * 5) + 100 : (56 * 7) + 40 ,
                          child: DataTable2(
                            columnSpacing: 10,
                            horizontalMargin: 6,
                            minWidth: 1050,
                            dataRowHeight: 60,
                            columns: const [
                              DataColumn2(
                                label: Text(
                                  'Order',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.L,
                              ),
                              DataColumn2(
                                label: Text(
                                  'Total Price',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text(
                                  'User',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text(
                                  'Status',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text(
                                  'Refund',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.S,
                              ),
                              DataColumn(
                                label: Text(
                                  'Action',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: orders!.where((order) => order.isRefunded == true).map((filteredOrder) => buildDataRow(filteredOrder)).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      );
    }
  }
}
