// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:ecommerce_app/models/cart_item.dart';

class Cart {
  final String? id;
  final String? userId;
  final List<CartItem> cartItems;

  const Cart({
    this.id,
    this.userId,
    required this.cartItems,
  });

  double get totalPrice {
    double total = 0;
    for (var cartItem in cartItems) {
      if (cartItem.product != null) {
        total += cartItem.product!.price * (cartItem.quantity ?? 0);
      }
    }
    return total;
  }

  int get itemsCount {
    return cartItems.length;
  }

  Cart copyWith({
    String? id,
    String? userId,
    List<CartItem>? cartItems,
  }) {
    return Cart(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'cartItems': cartItems.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      cartItems: map['items'] != null
          ? List<CartItem>.from(
              (map['items']).map<CartItem>(
                (x) => CartItem.fromMap(x as Map<String, dynamic>),
              ),
            )
          : List<CartItem>.empty(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Cart(id: $id, userId: $userId, cartItems: $cartItems)';

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id && other.userId == userId && listEquals(other.cartItems, cartItems);
  }

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ cartItems.hashCode;
}
