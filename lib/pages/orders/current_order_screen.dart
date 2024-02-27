import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/pages/drink/widgets/single_product.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  // static const String routeName = "/current_order_screen";
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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

  int calculateCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const defaultWidth = 180; // Default width of each grid item
    const minCrossAxisCount = 2; // Minimum number of columns

    if (screenWidth > 779) {
      final calculatedCount = (screenWidth / defaultWidth / 1.25).floor();
      return calculatedCount > minCrossAxisCount
          ? calculatedCount
          : minCrossAxisCount;
    } else {
      final calculatedCount = (screenWidth / defaultWidth).floor();
      return calculatedCount > minCrossAxisCount
          ? calculatedCount
          : minCrossAxisCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
              child: const CustomText(
                text: "Current Orders",
                size: 24,
                color: AppColor.secondary,
                weight: FontWeight.bold,
              ),
            )
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                orders == null || productList == null
                    ? const Loader()
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orders!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: calculateCrossAxisCount(
                              context), // Calculate the cross axis count dynamically
                        ),
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

                          return Column(
                            children: [
                              SizedBox(
                                height: 132,
                                child: SingleProduct(
                                  image: productFound.image,
                                ),
                              ),
                              Container(
                                width: 180,
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        productFound
                                            .name, // Use matchingProduct instead of product
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
