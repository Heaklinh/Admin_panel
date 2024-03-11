import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/pages/drink/add_product_page.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
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
      },
    );
  }

  int calculateCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const defaultWidth = 200; // Default width of each grid item
    const minCrossAxisCount = 2; // Minimum number of columns

    if (screenWidth > 779) {
      final calculatedCount = (screenWidth / defaultWidth / 1.3).floor();
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
                text: "Drinks",
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
                if (products == null)
                  const Loader()
                else
                  GridView.builder(
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
                            child: Container(
                              margin: EdgeInsets.all(16),
                              height: 200,
                              decoration: const ShapeDecoration(
                                color: AppColor.primary,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(24),
                                  ),
                                ),
                              ),
                              width: 180,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 40,
                                    color: AppColor.white,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Add Drink",
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        final productData = products![index];
                        return Container(
                          margin: const EdgeInsets.all(16),
                          decoration: const ShapeDecoration(
                            color: AppColor.white,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(24),
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //   decoration: ShapeDecoration(
                              //       color: AppColor.white,
                              //       shape: BeveledRectangleBorder(
                              //           borderRadius: BorderRadius.only(
                              //               bottomRight: Radius.circular(24)))),
                              //   height: 200,
                              //   child: Column(
                              //     children: [
                              //       SizedBox(
                              //         height: 132 / 1.5,
                              //         child: Image.network(
                              //           productData.image,
                              //           fit: BoxFit.fitHeight,
                              //           width: 180,
                              //         ),
                              //       ),
                              //       const SizedBox(
                              //         height: 4,
                              //       ),
                              //       Expanded(
                              //         child: Container(
                              //           width: 180,
                              //           padding: const EdgeInsets.only(
                              //               left: 10, right: 10),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.spaceBetween,
                              //             children: [
                              //               Text(
                              //                 productData.name,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 maxLines: 2,
                              //                 style: const TextStyle(
                              //                     fontWeight: FontWeight.bold,
                              //                     fontSize: 16),
                              //               ),
                              //               Text(
                              //                 "\$${productData.price}",
                              //                 overflow: TextOverflow.ellipsis,
                              //                 maxLines: 2,
                              //                 style: const TextStyle(
                              //                     fontSize: 16,
                              //                     fontWeight: FontWeight.bold,
                              //                     fontFamily: "Niradei"),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //       Row(
                              //         children: [
                              //           IconButton(
                              //             onPressed: () {
                              //               deleteProduct(productData, index);
                              //             },
                              //             icon: const Icon(
                              //               Icons.edit,
                              //             ),
                              //           ),
                              //           IconButton(
                              //             onPressed: () {
                              //               deleteProduct(productData, index);
                              //             },
                              //             icon: const Icon(
                              //               Icons.delete_outline,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              Expanded(
                                child: SizedBox(
                                  height: 132 / 1.5,
                                  child: Image.network(
                                    productData.image,
                                    fit: BoxFit.fitHeight,
                                    width: 180,
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            productData.name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: AppColor.secondary,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Niradei",
                                                fontSize: ResponsiveWidget
                                                        .isSmallScreen(context)
                                                    ? 14
                                                    : 16),
                                          ),
                                        ),
                                        Text(
                                          '\$${productData.price}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  productData.description,
                                  style: TextStyle(
                                      color: AppColor.disable,
                                      fontSize: ResponsiveWidget.isSmallScreen(
                                              context)
                                          ? 12
                                          : 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        //editProduct(productData, index);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
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
                              )
                            ],
                          ),
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
