import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:data_table_2/data_table_2.dart';
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
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    productList = await adminServices.fetchAllProducts(context);
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
      statusText = "Pick Up";
    } else {
      statusText = "Done";
    }
    return statusText;
  }

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
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              orders == null || productList == null
                  ? const Loader()
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: orders!.length,
                      itemBuilder: (context, index) {
                        bool found = false;
                          final orderData = orders![index];
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
                        return InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 36, vertical: 18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.network(
                                          productFound.image,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Order Number: ${orderData.orderNumber}",
                                              style: const TextStyle(
                                                fontFamily: "Niradei",
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              productFound.name,
                                              style: const TextStyle(
                                                  fontFamily: "Niradei",
                                                  fontSize: 11),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: const ShapeDecoration(
                                            color: AppColor.primary,
                                            shape: BeveledRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(4),
                                              ),
                                            ),
                                          ),
                                          child: Container(
                                            margin: const EdgeInsets.all(6),
                                            child: Text(
                                              getOrderStatusText(
                                                  orderData.status,
                                                  orderData.queue),
                                              style: const TextStyle(
                                                  color: AppColor.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const DividerTheme(
                                data: DividerThemeData(
                                  space: 0, // Set the spacing to zero
                                ),
                                child: Divider(),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
