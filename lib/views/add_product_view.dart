import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../controllers/productController.dart';
import '../models/product.dart';
import '../widgets/label_text_field_widget.dart';

class AddProductView extends StatefulWidget {
  AddProductView({Key? key}) : super(key: key);

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final ProductController controller = Get.find<ProductController>();

  final nameController = TextEditingController();

  final priceController = TextEditingController();

  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Add Product',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              LabelTextField(
                inputType: TextInputType.text,
                defaultText: 'Product Name',
                controller: nameController,
                readOnly: false,
              ),
              const Gap(20),
              LabelTextField(
                inputType: TextInputType.number,
                defaultText: 'Product Price',
                controller: priceController,
                readOnly: false,
              ),
              const Gap(20),
              LabelTextField(
                inputType: TextInputType.text,
                defaultText: 'Product Description',
                controller: descriptionController,
                readOnly: false,
              ),
              TextButton(
                onPressed: () {
                  int? price = int.tryParse(priceController.text);
                  String name = nameController.text;
                  String description = descriptionController.text;

                  final newProduct = Product(
                    name: name,
                    price: price,
                    description: description,
                    history: [Product.createHistoryEntry('Created', 'Initial creation')],
                  );
                  controller.addProduct(newProduct);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
