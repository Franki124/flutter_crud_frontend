import 'dart:convert';

class Product {
  String? id;
  String? name;
  String? description;
  int? price;
  List<Map<String, String>>? history;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.history,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'],
      name: json['Name'],
      description: json['Description'],
      price: json['Price'],
      history: json['History'] != null
          ? List<Map<String, String>>.from(
          json['History'].map((x) => Map<String, String>.from(x)))
          : null,
    );
  }

  static Map<String, String> createHistoryEntry(String action, String details) {
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'action': action,
      'details': details,
    };
  }

  void addHistoryEntry(String action, String details) {
    history = history ?? [];
    history!.add(Product.createHistoryEntry(action, details));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'history': history?.map((e) => e).toList(),
    };
  }

  static List<Product> productFromJson(String str) {
    final jsonData = json.decode(str);
    return List<Product>.from(jsonData.map((x) => Product.fromJson(x)));
  }

  static String productToJson(Product data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }
}