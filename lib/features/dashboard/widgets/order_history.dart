import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/constants/waiting_dialog.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/constants/responsiveness.dart';
import 'package:admin_panel/features/orders/services/order_services.dart';
import 'package:admin_panel/common/widgets/custom_text.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  final List<Order>? orderHistoryList;
  final List<Product>? productList;
  final List<User>? userList;
  final VoidCallback onOrderDeleted;
  const OrderHistory({super.key, required this.orderHistoryList, required this.productList, required this.userList, required this.onOrderDeleted});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final TextEditingController textController = TextEditingController();
  final OrderServices orderServices = OrderServices();
  late Order orderData;

  Future<void> deleteOrder()async{
    await orderServices.deleteOrder(
      context: context,
      order: orderData,
      onSuccess: widget.onOrderDeleted,
    );
    if(mounted){
      Navigator.pop(context);
      showSnackBar(context, "Order deleted successfully");
    }
  }

  Future<void> refundOrder()async{
    await orderServices.refundOrder(
      context: context,
      order: orderData,
      onSuccess: widget.onOrderDeleted,
    );
    if(mounted){
      Navigator.pop(context);
      showSnackBar(context, "Order refunded successfully");
    }
  }

  Future<void> clearAllOrder() async {

    await Future.forEach(widget.orderHistoryList!, (Order order) async{
      await orderServices.deleteOrder(
        context: context, 
        order: order, 
        onSuccess: widget.onOrderDeleted
      );
    });

    setState(() {
      Navigator.pop(context);
    });
    if(mounted){
      showSnackBar(context, "All history order has been clear");
    }
  }

  @override
  Widget build(BuildContext context) {

    CustomText customText(String text) {
      return CustomText(
        text: text,
        size: 14,
        color: AppColor.disable,
        weight: FontWeight.normal,
      );
    }

    DataRow buildDataRow(Order order) {

      bool pFound = false;
      late Product productFound;
      for (int i = 0; i < widget.productList!.length; i++) {
        final products = widget.productList![i];
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
      for (int i = 0; i < widget.userList!.length; i++) {
        final users = widget.userList![i];
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
                      title: const Text('Refund Order'), 
                      content:const Text('Are you sure you want to refund this order?')
                    );
                    if (confirmLogout) {
                      orderData = order;
                      if(!context.mounted) return;
                      waitingDialog(context, refundOrder, "Refunding Order...");
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: "Order History",
                size: 15,
                color: AppColor.secondary,
                weight: FontWeight.bold,
              ),
              TextButton(
                onPressed: () async {
                  bool confirmLogout = await confirm(
                    context, 
                    title: const Text('Clear All History'), 
                    content:const Text('Are you sure you want to clear all the history?')
                  );
                  if (confirmLogout) {  
                    if(!context.mounted) return;
                    waitingDialog(context, clearAllOrder, "Clearing Orders...");
                  }
                },
                child: const CustomText(
                  text: "Clear",
                  size: 14,
                  color: AppColor.secondary,
                  weight: FontWeight.bold,
                ),
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
                DataColumn2(
                  label: const Text(
                    'Action',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  size: ResponsiveWidget.isSmallScreen(context)
                      ? ColumnSize.L
                      : ColumnSize.S,
                ),
              ],
              rows: List<DataRow>.generate(
                widget.orderHistoryList!.length,
                (index) => buildDataRow(widget.orderHistoryList![index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
