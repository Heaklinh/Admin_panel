import 'dart:io';

import 'package:admin_panel/common/widgets/custom_textfield.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  static const String routeName = "/add_product_page";
  
  final VoidCallback onProductAdded; 
  const AddProductPage({super.key, required this.onProductAdded});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  AdminServices adminServices = AdminServices();

    final TextEditingController productNameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    File? pickedImage;
    Uint8List webImage = Uint8List(8);

    void submitForm() {
      if (formKey.currentState!.validate()) {
        adminServices.addProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          image: pickedImage ?? File('a'),
          onProductAdded: widget.onProductAdded,
        );
      }
    }

    Future<void> selectImage() async {
      if (!kIsWeb) {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          var selected = File(image.path);
          setState(() {
            pickedImage = selected;
          });
        } else {
          if (!context.mounted) return;
          showSnackBar(context, 'No image has been selected');
        }
      } else if (kIsWeb) {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          final Uint8List f = await image.readAsBytes();
          setState((){
            webImage = f;
            pickedImage = File(image.path);
          });
        } else {
          if (!context.mounted) return;
          showSnackBar(context, 'No image has been selected');
        }
      } else {
        showSnackBar(context, 'Something when wrong');
      }
    }

  @override
  Widget build(BuildContext context) {
    final double dialogWidth = MediaQuery.of(context).size.width * 0.3;
    return AlertDialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColor.white,
      title: const Text('Add Product'),
      shape:
          BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: dialogWidth,
              ),

              // Add Image
              GestureDetector(
                onTap: selectImage,
                child: DottedBorder(
                  dashPattern: const [10, 4],
                  strokeCap: StrokeCap.round,
                  child: Container(
                      width: double.infinity,
                      height: dialogWidth,
                      decoration: ShapeDecoration(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: pickedImage == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.upload_file,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Upload Image Here",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[800]),
                                ),
                              ],
                            )
                          : kIsWeb
                              ? Image.memory(webImage, fit: BoxFit.fill)
                              : Image.file(
                                  pickedImage!,
                                  fit: BoxFit.fill,
                                )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Add Product Name
              CustomTextField(
                controller: productNameController,
                hintText: 'Product Name',
              ),
              const SizedBox(
                height: 10,
              ),
              // Add Product Description
              CustomTextField(
                controller: descriptionController,
                hintText: 'Description',
                maxLines: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              // Add Product Quantity
              CustomTextField(
                  controller: priceController, hintText: 'Price'),
              const SizedBox(height: 10),

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
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: submitForm,
          child: const Text('Add'),
        ),
      ],
    );
  }
}