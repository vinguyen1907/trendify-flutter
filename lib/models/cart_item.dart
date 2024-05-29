// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product.dart';

class CartItem {
  final String? id;
  final Product? product;
  final int? quantity;
  final String? size;
  final Color? color;

  CartItem({
    this.id,
    this.product,
    this.quantity,
    this.size,
    this.color,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'],
      size: map['size'],
      color: map['color'] != null ? Color(int.parse(map['color'])) : null,
    );
  }

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
    String? size,
    Color? color,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product': product?.toMap(),
      'quantity': quantity,
      'size': size,
      'color': color?.value,
    };
  }

  String toJson() => json.encode(toMap());
}
