import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/order.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/pages/drink/widgets/single_product.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:flutter/material.dart';

class CurrentOrderScreen extends StatefulWidget {
  static const String routeName = "/current_order_screen";
  const CurrentOrderScreen({super.key});

  @override
  State<CurrentOrderScreen> createState() => _CurrentOrderScreenState();
}

class _CurrentOrderScreenState extends State<CurrentOrderScreen> {
  List<Order>? orders;
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
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
        const SizedBox(
          height: 24,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                orders == null || products == null
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
                          final orderData = orders![index];
                          final matchingProduct = products!.firstWhere(
                            (product) => product.id == orderData.productID,
                          );

                          return Column(
                            children: [
                              SizedBox(
                                height: 132,
                                child: SingleProduct(
                                  image: matchingProduct.image, 
                                ),
                              ),
                              Container(
                                width: 180,
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        matchingProduct.name, // Use matchingProduct instead of product
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
