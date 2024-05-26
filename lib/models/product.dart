// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String code;
  final String categoryId;
  final String name;
  final String brand;
  final String description;
  final double price;
  final String? outerMaterial;
  final String? innerMaterial;
  final String? sole;
  final String? closure;
  final String? shoeWidth;
  final String? heelType;
  final String? heelHeight;
  final double averageRating;
  final int reviewCount;
  final List<String> imageUrls;
  final int soldCount;
  final int stockCount;
  final DateTime createdAt;

  const Product(
      {required this.id,
      required this.code,
      required this.categoryId,
      required this.name,
      required this.brand,
      required this.description,
      required this.price,
      this.outerMaterial,
      this.innerMaterial,
      this.sole,
      this.closure,
      this.shoeWidth,
      this.heelType,
      this.heelHeight,
      required this.averageRating,
      required this.reviewCount,
      required this.imageUrls,
      required this.soldCount,
      required this.stockCount,
      required this.createdAt});

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      code: json['code'],
      categoryId: json['categoryId'] ?? "",
      name: json['name'] ?? "",
      brand: json['brand'] ?? "No brand",
      description: json['description'] ?? "No description",
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      outerMaterial: json['outerMaterial'],
      innerMaterial: json['innerMaterial'],
      sole: json['sole'],
      closure: json['closure'],
      shoeWidth: json['shoeWidth'],
      heelType: json['heelType'],
      heelHeight: json['heelHeight'],
      averageRating: double.tryParse(json['reviewScore'].toString()) ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      imageUrls: json['imageUrls'] != null ? List<String>.from(json['imageUrls']) : <String>[],
      soldCount: json['soldCount'] ?? 0,
      stockCount: json['stockCount'] ?? 0,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [id, name, price, brand];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'brand': brand,
      'description': description,
      'price': price,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
      'imgUrl': imageUrls,
      'soldCount': soldCount,
      'stockCount': stockCount,
      'createdAt': createdAt,
    };
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
