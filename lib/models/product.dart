import 'dart:convert';

class Product {
  final String name;
  final String description;
  final String image;
  final double price;
  final String? id;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
