import 'dart:convert';

import 'package:ecommerce_app/extensions/extensions.dart';

import 'promotion.dart';

class FreeShippingPromotion extends Promotion {
  FreeShippingPromotion({
    required super.id,
    required super.code,
    required super.content,
    required super.imgUrl,
    required super.type,
    super.minimumOrderValue,
    super.maximumDiscountValue,
    required super.startTime,
    required super.endTime,
    required super.quantity,
    required super.usedQuantity,
    required super.isDeleted,
  });

  factory FreeShippingPromotion.fromMap(Map<String, dynamic> map) {
    return FreeShippingPromotion(
      id: map['id'] as String,
      code: map['code'] as String,
      content: map['content'] as String,
      imgUrl: map['imgUrl'] as String,
      type: (map['type'] as String).toPromotion(),
      minimumOrderValue: map['minimumOrderValue']?.toDouble(),
      maximumDiscountValue: map['maximumDiscountValue']?.toDouble(),
      startTime: map['startTime'].toDate(),
      endTime: map['endTime'].toDate(),
      quantity: map['quantity'] as int?,
      usedQuantity: map['usedQuantity'] ?? 0,
      isDeleted: map['isDeleted'] ?? false,
    );
  }

  factory FreeShippingPromotion.fromJson(String source) => FreeShippingPromotion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String get amountString => "0";

  @override
  double get amount => 0;
}
