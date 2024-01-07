import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import '../controllers/productController.dart';
import '../models/product.dart';
import 'add_product_view.dart';
import 'detail_product_view.dart';
import 'edit_product_view.dart';

class ProductListPage extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Product Manager',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        if (controller.products.isEmpty) {
          return const Center(
            child: Text(
              'No products yet ;D',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return _buildProductItem(context, controller.products[index]);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductView()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, Product product) {
    print('Product Details: ${product.name}, ${product.price}');
    return InkWell(
      onTap: () => _navigateToProductDetail(context, product),
      child: Padding(
        padding: const EdgeInsets.only(top: 14, left: 10, right: 10),
        child: Slidable(
          key: ValueKey(product.id),
          startActionPane: ActionPane(
            extentRatio: 0.26,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) => _editProduct(context, product),
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              ),
              const Gap(10),
            ],
          ),
          endActionPane: ActionPane(
            extentRatio: 0.26,
            motion: const ScrollMotion(),
            children: [
              const Gap(10),
              SlidableAction(
                onPressed: (_) => _deleteProduct(product),
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightBlueAccent.shade100.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    product.name ?? 'Unnamed Product',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    '\$ ${product.price?.toStringAsFixed(2) ?? '0.00'}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editProduct(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProductView(product: product)),
    );
  }

  void _deleteProduct(Product product) {
    if (product.id != null) {
      controller.deleteProduct(product.id!);
    }
  }

  void _navigateToProductDetail(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductDetailPage(product: product)),
    );
  }
}
