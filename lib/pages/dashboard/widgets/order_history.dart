import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

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
              blurRadius: 12)
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
                100,
                (index) => DataRow(
                  cells: [
                    const DataCell(CustomText(
                        text: "Eric",
                        size: 12,
                        color: AppColor.disable,
                        weight: FontWeight.normal)),
                    const DataCell(CustomText(
                        text: "Eric",
                        size: 12,
                        color: AppColor.disable,
                        weight: FontWeight.normal)),
                    const DataCell(CustomText(
                        text: "Eric",
                        size: 12,
                        color: AppColor.disable,
                        weight: FontWeight.normal)),
                    const DataCell(CustomText(
                        text: "Eric",
                        size: 12,
                        color: AppColor.disable,
                        weight: FontWeight.normal)),
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
                            text: "Preparing",
                            size: 12,
                            color: AppColor.white,
                            weight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
