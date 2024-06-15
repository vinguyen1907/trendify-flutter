// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_app/extensions/extensions.dart';
import 'package:ecommerce_app/extensions/order_status_extensions.dart';

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
  final ShippingAddress? address;
  final OrderSummary? orderSummary;
  final bool isCompleted;
  final String paymentMethod;
  final bool isPaid;
  final OrderStatus currentOrderStatus;
  final List<OrderProductDetail>? items;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.customerId,
    required this.customerName,
    required this.customerPhoneNumber,
    this.address,
    this.orderSummary,
    required this.isCompleted,
    required this.paymentMethod,
    required this.isPaid,
    required this.currentOrderStatus,
    this.items,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'orderNumber': orderNumber,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhoneNumber': customerPhoneNumber,
      'address': address?.toMap(),
      'orderSummary': orderSummary?.toMap(),
      'isCompleted': isCompleted,
      'paymentMethod': paymentMethod,
      'isPaid': isPaid,
      'currentOrderStatus': currentOrderStatus.toOrderStatusString(),
      'items': items?.map((e) => e.toMap()).toList(),
      'createdAt': createdAt,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'].toString(),
      orderNumber: map['orderNumber'].toString(),
      customerId: map['customerId'].toString(),
      customerName: map['customerName'].toString(),
      customerPhoneNumber: map['customerPhoneNumber'] ?? "Not have phone number",
      address: map['address'] != null ? ShippingAddress.fromMap(map['address'] as Map<String, dynamic>) : null,
      orderSummary: map['orderSummary'] != null ? OrderSummary.fromMap(map['orderSummary'] as Map<String, dynamic>) : null,
      isCompleted: map['isCompleted'] as bool,
      paymentMethod: map['paymentMethod'] as String,
      isPaid: map['isPaid'] as bool,
      currentOrderStatus: (map['currentOrderStatus'] as String?)?.toLowerCase().toOrderStatus() ?? OrderStatus.pending,
      items:
          map['items'] != null ? List<OrderProductDetail>.from(map['items'].map((e) => OrderProductDetail.fromMap(e as Map<String, dynamic>))) : null,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
    DateTime? createdAt,
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
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
