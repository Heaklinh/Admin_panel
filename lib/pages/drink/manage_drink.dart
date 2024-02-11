import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/pages/drink/add_product_page.dart';
import 'package:admin_panel/pages/drink/widgets/single_product.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/pages/widgets/side_bar.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:flutter/material.dart';

class ManageDrink extends StatefulWidget {
  static const String routeName = "/manage_drink";
  const ManageDrink({super.key});

  @override
  State<ManageDrink> createState() => _ManageDrinkState();
}

class _ManageDrinkState extends State<ManageDrink> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void _handleProductAdded() {
    fetchAllProducts(); // Fetch the updated list of products
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
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
              child: CustomText(
                text: menuController.activeItem,
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                //   child: DottedBorder(
                //     dashPattern: const [10, 4],
                //     strokeCap: StrokeCap.round,
                //     child: Container(
                //       width: width / 7,
                //       height: width / 7,
                //       decoration: ShapeDecoration(
                //         shape: BeveledRectangleBorder(
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //       ),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const Icon(
                //             Icons.folder_open,
                //             size: 40,
                //           ),
                //           const SizedBox(
                //             height: 15,
                //           ),
                //           Text(
                //             "Add Drink",
                //             style: TextStyle(
                //               fontSize: width / 60,
                //               color: Colors.grey[400],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),

                products == null
                    ? const Loader()
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (products!.length + 1),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: calculateCrossAxisCount(
                              context), // Calculate the cross axis count dynamically
                        ),
                        itemBuilder: (context, index) {
                          if (index == products!.length) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddProductPage(
                                          onProductAdded: _handleProductAdded);
                                    });
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 132,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      child: Container(
                                        width: 180,
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.folder_open,
                                                size: 40),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "Add Drink",
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.grey[400],
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

                          final productData = products![index];
                          return Column(
                            children: [
                              SizedBox(
                                height: 132,
                                child: SingleProduct(
                                  image: productData.image,
                                ),
                              ),
                              Container(
                                width: 180,
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        productData.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        deleteProduct(productData, index);
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline,
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
