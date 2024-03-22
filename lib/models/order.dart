// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/extensions/order_status_extensions.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';

import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/models/order_status.dart';
import 'package:ecommerce_app/models/order_summary.dart';
import 'package:ecommerce_app/models/shipping_address.dart';

class OrderModel {
  final String id;
  final String orderNumber;
  final String customerId;
  final String customerName;
  final String customerPhoneNumber;
  final ShippingAddress address;
  final OrderSummary orderSummary;
  final bool isCompleted;
  final String paymentMethod;
  final bool isPaid;
  final OrderStatus currentOrderStatus;
  final Timestamp createdAt;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.customerId,
    required this.customerName,
    required this.customerPhoneNumber,
    required this.address,
    required this.orderSummary,
    required this.isCompleted,
    required this.paymentMethod,
    required this.isPaid,
    required this.currentOrderStatus,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderNumber': orderNumber,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhoneNumber': customerPhoneNumber,
      'address': address.toMap(),
      'orderSummary': orderSummary.toMap(),
      'isCompleted': isCompleted,
      'paymentMethod': paymentMethod,
      'isPaid': isPaid,
      'currentOrderStatus': currentOrderStatus.toOrderStatusString(),
      'createdAt': createdAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as String,
      orderNumber: map['orderNumber'] as String,
      customerId: map['customerId'] as String,
      customerName: map['customerName'] as String,
      customerPhoneNumber: map['customerPhoneNumber'] ?? "Not have phone number",
      address: ShippingAddress.fromMap(map['address'] as Map<String, dynamic>),
      orderSummary:
          OrderSummary.fromMap(map['orderSummary'] as Map<String, dynamic>),
      isCompleted: map['isCompleted'] as bool,
      paymentMethod: map['paymentMethod'] as String,
      isPaid: map['isPaid'] as bool,
      currentOrderStatus: (map['currentOrderStatus'] as String).toOrderStatus(),
      createdAt: map['createdAt'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  OrderModel copyWith({
    String? id,
    String? orderNumber,
    String? customerId,
    String? customerName,
    String? customerPhoneNumber,
    ShippingAddress? address,
    List<OrderProductDetail>? items,
    OrderSummary? orderSummary,
    bool? isCompleted,
    String? paymentMethod,
    bool? isPaid,
    OrderStatus? currentOrderStatus,
    Timestamp? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerPhoneNumber: customerPhoneNumber ?? this.customerPhoneNumber,
      address: address ?? this.address,
      orderSummary: orderSummary ?? this.orderSummary,
      isCompleted: isCompleted ?? this.isCompleted,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPaid: isPaid ?? this.isPaid,
      currentOrderStatus: currentOrderStatus ?? this.currentOrderStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
