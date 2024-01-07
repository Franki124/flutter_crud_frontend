import 'package:get/get.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  var products = <Product>[].obs;
  final baseUrl = 'http://localhost:8080';

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      if (response.statusCode == 200) {
        print('Raw JSON response: ${response.body}');
        final productList = Product.productFromJson(response.body);
        print('Fetched Products: $productList');
        products.value = productList;
      } else {
        Get.snackbar('Error', 'Failed to fetch products');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products: $e');
    }
  }

  void addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/product/create'),
        body: Product.productToJson(product),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 201) {
        fetchProducts();
      } else {
        Get.snackbar('Error', 'Failed to add product');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add product: $e');
    }
  }

  void updateProduct(Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/product/update'),
        body: Product.productToJson(product),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        fetchProducts();
      } else {
        Get.snackbar('Error', 'Failed to update product');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product: $e');
    }
  }

  void deleteProduct(String productId) async {
    print('Deleting product with ID: $productId');
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/product/delete?id=$productId'),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        fetchProducts();
      } else {
        Get.snackbar('Error', 'Failed to delete product');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete product: $e');
    }
  }
}
