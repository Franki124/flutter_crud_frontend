import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import '../models/product.dart';
import '../controllers/productController.dart';
import '../widgets/label_text_field_widget.dart';

class EditProductView extends StatefulWidget {
  final Product product;

  const EditProductView({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductViewState createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  late final TextEditingController nameController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.name);
    priceController = TextEditingController(text: widget.product.price?.toString());
    descriptionController = TextEditingController(text: widget.product.description);
  }

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Edit Product',
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
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
        ),
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
                  final updatedProduct = Product(
                    id: widget.product.id,
                    name: nameController.text,
                    description: descriptionController.text,
                    price: int.tryParse(priceController.text),
                    history: [...?widget.product.history, Product.createHistoryEntry('Updated', 'Details')],
                  );
                  controller.updateProduct(updatedProduct);
                  Navigator.pop(context);
                },
                child: const Text('Save'),
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
