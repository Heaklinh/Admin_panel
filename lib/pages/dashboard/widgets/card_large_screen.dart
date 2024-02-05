import 'package:admin_panel/constants/color.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CardLargeScreen extends StatefulWidget {
  const CardLargeScreen({super.key});

  @override
  State<CardLargeScreen> createState() => _CardLargeScreenState();
}

class _CardLargeScreenState extends State<CardLargeScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
          child: GestureDetector(
            onTap: () => openDialog(context),
            child: DottedBorder(
              dashPattern: const [10, 4],
              strokeCap: StrokeCap.round,
              child: Container(
                width: width / 8,
                height: width / 8,
                decoration: ShapeDecoration(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.folder_open,
                      size: 40,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Add Drink",
                      style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openDialog(BuildContext context) async {
    double dialogWidth = MediaQuery.of(context).size.width * 0.7;

    await showDialog(
      context: context,
      builder: (context) => SizedBox(
        width: dialogWidth,
        child: AlertDialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: AppColor.white,
          title: const Text('Add Product'),
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Add Product Name
                  TextFormField(
                    controller: productNameController,
                    decoration:
                        const InputDecoration(labelText: 'Product Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product name';
                      }
                      return null;
                    },
                  ),
                  // Add Product Description
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 5,
                    // Aligns text to the top

                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product description';
                      }
                      return null;
                    },
                  ),
                  // Add Product Quantity
                  TextFormField(
                    controller: quantityController,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product quantity';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid quantity';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Add Image
                  DottedBorder(
                    dashPattern: const [10, 4],
                    strokeCap: StrokeCap.round,
                    child: Container(
                      width: dialogWidth / 2,
                      height: 100,
                      decoration: ShapeDecoration(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.upload_file,
                            size: 24,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Upload Image Here",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[800]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: _selectImage,
                  //   child: Text('Upload Image'),
                  // ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
