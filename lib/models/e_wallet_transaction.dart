// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/extensions/string_extensions.dart';

class EWalletTransaction {
  final String id;
  final EWalletTransactionType type;
  final DateTime createdTime;
  EWalletTransaction({
    required this.id,
    required this.type,
    required this.createdTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.name,
      'createdTime': createdTime.millisecondsSinceEpoch,
    };
  }

  factory EWalletTransaction.fromMap(Map<String, dynamic> map) {
    final EWalletTransactionType? type =
        stringToEWalletTransactionType[map['type']];
    switch (type) {
      case EWalletTransactionType.topUp:
        return TopUpTransaction.fromMap(map);
      case EWalletTransactionType.payment:
        return PaymentTransaction.fromMap(map);
      default:
        return TopUpTransaction.fromMap(map);
    }
  }

  String toJson() => json.encode(toMap());

  factory EWalletTransaction.fromJson(String source) =>
      EWalletTransaction.fromMap(json.decode(source) as Map<String, dynamic>);

  EWalletTransaction copyWith({
    String? id,
    EWalletTransactionType? type,
    DateTime? createdTime,
  }) {
    return EWalletTransaction(
      id: id ?? this.id,
      type: type ?? this.type,
      createdTime: createdTime ?? this.createdTime,
    );
  }
}

class TopUpTransaction extends EWalletTransaction {
  final double amount;
  final String cardNumber;
  TopUpTransaction({
    required super.id,
    required super.type,
    required super.createdTime,
    required this.amount,
    required this.cardNumber,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.name,
      'createdTime': createdTime,
      'amount': amount,
      'cardNumber': cardNumber,
    };
  }

  factory TopUpTransaction.fromMap(Map<String, dynamic> map) {
    return TopUpTransaction(
      id: map['id'] as String,
      type: (map['type'] as String).toEWalletTransactionType(),
      createdTime: DateTime.fromMicrosecondsSinceEpoch(
          (map['createdTime'] as Timestamp).microsecondsSinceEpoch),
      amount: map['amount'] as double,
      cardNumber: map['cardNumber'] as String,
    );
  }

  @override
  TopUpTransaction copyWith({
    String? id,
    EWalletTransactionType? type,
    DateTime? createdTime,
    double? amount,
    String? cardNumber,
  }) {
    return TopUpTransaction(
      id: id ?? this.id,
      type: type ?? this.type,
      createdTime: createdTime ?? this.createdTime,
      amount: amount ?? this.amount,
      cardNumber: cardNumber ?? this.cardNumber,
    );
  }
}

class PaymentTransaction extends EWalletTransaction {
  final String cardNumber;
  // final String productId;
  // final String productName;
  // final String productImageUrl;
  // final String size;
  // final Color color;
  // final int quantity;
  final List<CartItem> items;
  final double amount;
  final double promotionAmount;
  final double shippingFee;

  PaymentTransaction({
    required super.id,
    required super.type,
    required super.createdTime,
    required this.cardNumber,
    required this.items,
    // required this.productId,
    // required this.productName,
    // required this.productImageUrl,
    // required this.size,
    // required this.color,
    // required this.quantity,
    required this.amount,
    required this.promotionAmount,
    required this.shippingFee,
  });

  double get totalAmount => amount + shippingFee - promotionAmount;

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.name,
      'createdTime': createdTime,
      'cardNumber': cardNumber,
      // 'productId': productId,
      // 'productName': productName,
      // 'productImageUrl': productImageUrl,
      // 'size': size,
      // 'color': color.value,
      // 'quantity': quantity,
      'items': items.map((item) => item.toMap()).toList(),
      'amount': amount,
      'promotionAmount': promotionAmount,
      'shippingFee': shippingFee,
    };
  }

  factory PaymentTransaction.fromMap(Map<String, dynamic> map) {
    return PaymentTransaction(
      id: map['id'] as String,
      type: (map['type'] as String).toEWalletTransactionType(),
      createdTime: DateTime.fromMicrosecondsSinceEpoch(
          (map['createdTime'] as Timestamp).millisecondsSinceEpoch),
      cardNumber: map['cardNumber'] as String,
      // productId: map['productId'] as String,
      // productName: map['productName'] as String,
      // productImageUrl: map['productImageUrl'] as String,
      // size: map['size'] as String,
      // color: (map['color'] as String).toColor(),
      // quantity: map['quantity'] as int,
      items: (map['items'] as List<dynamic>)
          .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
          .toList(),
      amount: map['amount'] as double,
      promotionAmount: map['promotionAmount'] as double,
      shippingFee: map['shippingFee'] as double,
    );
  }

  @override
  PaymentTransaction copyWith({
    String? id,
    EWalletTransactionType? type,
    DateTime? createdTime,
    String? cardNumber,
    String? productId,
    String? productName,
    String? productImageUrl,
    String? size,
    Color? color,
    // int? quantity,
    double? amount,
    double? promotionAmount,
    double? shippingFee,
  }) {
    return PaymentTransaction(
      id: id ?? this.id,
      type: type ?? this.type,
      createdTime: createdTime ?? this.createdTime,
      cardNumber: cardNumber ?? this.cardNumber,
      // productId: productId ?? this.productId,
      // productName: productName ?? this.productName,
      // productImageUrl: productImageUrl ?? this.productImageUrl,
      // size: size ?? this.size,
      // color: color ?? this.color,
      // quantity: quantity ?? this.quantity,
      items: items,
      amount: amount ?? this.amount,
      promotionAmount: promotionAmount ?? this.promotionAmount,
      shippingFee: shippingFee ?? this.shippingFee,
    );
  }
}

enum EWalletTransactionType {
  topUp,
  payment,
}

final Map<String, EWalletTransactionType> stringToEWalletTransactionType = {
  'topUp': EWalletTransactionType.topUp,
  'payment': EWalletTransactionType.payment,
};
