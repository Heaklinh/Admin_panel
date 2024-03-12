import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  final List<Order>? orderHistoryList;
  final List<Product>? productList;
  final List<User>? userList;
  const OrderHistory({super.key, required this.orderHistoryList, required this.productList, required this.userList});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final TextEditingController textController = TextEditingController();
  List<Order>? orders;
  List<Product>? productList;
  final AdminServices adminServices = AdminServices();
  final columns = ['Name', 'Order', 'Order Number', 'Total', 'Eidt'];
  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(
              column,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: "Niradei"),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {

    CustomText customText(String text) {
      return CustomText(
        text: text,
        size: 12,
        color: AppColor.disable,
        weight: FontWeight.normal,
      );
    }

    DataRow buildDataRow(Order order) {

      bool pFound = false;
      late Product productFound;
      for (int i = 0; i < productList!.length; i++) {
        final products = productList![i];
        if (products.id == order.productID) {
          productFound = products;
          pFound = true;
          break;
        }
        pFound = false;
      }

      if (!pFound) {
        productFound = Product(
          id: order.productID,
          name: 'Deleted Product',
          price: 0,
          description: 'Deleted Product',
          image:
              'https://res.cloudinary.com/dsx7eoho1/image/upload/v1708670880/Product/e4nbm5zqfq8cbkkvnat2.png',
        );
      }
      
      bool uFound = false;
      late User userFound;
      for (int i = 0; i < userList!.length; i++) {
        final users = userList![i];
        if (users.id == order.userID) {
          userFound = users;
          uFound = true;
          break;
        }
        uFound = false;
      }

      if(!uFound){
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
          requestedOTPCount: 0
        );
      }

      return DataRow(
        cells: [
          DataCell(customText(userFound.name)),
          DataCell(customText(productFound.name)),
          DataCell(customText(order.orderNumber.toString())),
          DataCell(customText("\$${order.totalPrice}")),
          DataCell(
            Container(
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 2,
              ),
              child: const CustomText(
                text: "Done",
                size: 12,
                color: AppColor.white,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            children: [
              CustomText(
                text: "Order History",
                size: 20,
                color: AppColor.secondary,
                weight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: (56 * 7) + 40,
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: [
                const DataColumn2(
                  label: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  size: ColumnSize.L,
                ),
                const DataColumn(
                  label: Text(
                    'Product',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const DataColumn(
                  label: Text(
                    'Order No.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const DataColumn(
                  label: Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn2(
                  label: const Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  size: ResponsiveWidget.isSmallScreen(context)
                      ? ColumnSize.L
                      : ColumnSize.S,
                ),
              ],
              columns: getColumns(columns),
              // [
              //   const DataColumn2(
              //     label: Text(
              //       'Name',
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //     size: ColumnSize.L,
              //   ),
              //   const DataColumn(
              //     label: Text(
              //       'Order',
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //   ),
              //   const DataColumn(
              //     label: Text(
              //       'Order No.',
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //   ),
              //   const DataColumn(
              //     label: Text(
              //       'Total',
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //   ),
              //   DataColumn2(
              //     label: const Text(
              //       'Status',
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //     size: ResponsiveWidget.isSmallScreen(context)
              //         ? ColumnSize.L
              //         : ColumnSize.S,
              //   ),
              // ],
              rows: List<DataRow>.generate(
                orderHistoryList!.length,
                (index) => buildDataRow(orderHistoryList![index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
