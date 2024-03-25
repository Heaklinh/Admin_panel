import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/constants/waiting_dialog.dart';
import 'package:admin_panel/models/maintain_toggle.dart';
import 'package:admin_panel/models/product.dart';
import 'package:admin_panel/pages/drink/add_product_page.dart';
import 'package:admin_panel/pages/drink/edit_product.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

class ManageDrink extends StatefulWidget {
  const ManageDrink({super.key});

  @override
  State<ManageDrink> createState() => _ManageDrinkState();
}

class _ManageDrinkState extends State<ManageDrink> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  late Product selectedProduct;

  MaintainToggle? maintainToggle;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
    fetchMaintainToggle();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    if(context.mounted){
      setState(() {});
    }
  }

  void _handleProductAdded() {
    fetchAllProducts(); 
  }

  Future<void> deleteProduct()async {
    await adminServices.deleteProduct(
      context: context,
      product: selectedProduct,
      onSuccess: () {
        _handleProductAdded();
      },
    );
  }
  
  fetchMaintainToggle() async {
    maintainToggle = await adminServices.fetchMaintainToggle(context: context, toggle: false);
    if(context.mounted){
      setState(() {});
    }
  }


  int calculateCrossAxisCount(double scrollViewWidth) {
    const defaultWidth = 200; // Default width of each grid item
    const minCrossAxisCount = 1; // Minimum number of columns
    const maxCrossAxisCount = 4;
    if (scrollViewWidth > 600) {
      final calculatedCount = (scrollViewWidth / defaultWidth / 1.5).floor();
      return calculatedCount.clamp(minCrossAxisCount, maxCrossAxisCount);
    } else {
      final calculatedCount = (scrollViewWidth / defaultWidth).floor();
      return calculatedCount > minCrossAxisCount
          ? calculatedCount
          : minCrossAxisCount;
    }
  }


  @override
  Widget build(BuildContext context) {
    return products == null || maintainToggle == null
    ? const Loader()
    : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                size: 1,
                color: Colors.white,
                weight: FontWeight.bold,
              )
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints){
                  final scrollViewWidth = constraints.maxWidth;
                  return ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      Column(
                        children: [
                            GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: (products!.length + 1),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: calculateCrossAxisCount(
                                      scrollViewWidth), // Calculate the cross axis count dynamically
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
                                        margin: const EdgeInsets.all(16),
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
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return EditProductPage(
                                                          onProductUpdated: _handleProductAdded, productData: productData);
                                                    });
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  bool confirmLogout = await confirm(
                                                    context, 
                                                    title: const Text('Delete'), 
                                                    content:const Text('Are you sure you want to delete this product?')
                                                  );
                                                  if (confirmLogout) {
                                                    if(!context.mounted) return;
                                                    selectedProduct = productData;
                                                    waitingDialog(context, deleteProduct, "Deleting Product...");
                                                  }
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
                    ]
                  );
                }
              ),
            ),
          ],
        ),
      );
  }
}
