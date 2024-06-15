import 'dart:convert';

import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String imgUrl;
  final int productsCount;

  const Category({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.productsCount,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'].toString(),
      name: map['name'],
      imgUrl: map['imageUrl'],
      productsCount: map['productsCount'] ?? 0,
    );
  }

  factory Category.fromJson(String json) {
    return Category.fromMap(jsonDecode(json));
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imgUrl,
        productsCount
      ];
}
