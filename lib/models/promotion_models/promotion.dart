// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_app/constants/enums/enums.dart';
import 'package:ecommerce_app/extensions/promotion_type_extensions.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';

import 'promotion_models.dart';

class Promotion {
  final String id;
  final String code;
  final String content;
  final String imgUrl;
  final PromotionType type;
  final double? minimumOrderValue;
  final double? maximumDiscountValue;
  final DateTime startTime;
  final DateTime endTime;
  final int? quantity; // if it is null, it means unlimited
  final int usedQuantity;
  final bool isDeleted;

  Promotion({
    required this.id,
    required this.code,
    required this.content,
    required this.imgUrl,
    required this.type,
    this.minimumOrderValue,
    this.maximumDiscountValue,
    required this.startTime,
    required this.endTime,
    required this.quantity,
    required this.usedQuantity,
    required this.isDeleted,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'content': content,
      'imgUrl': imgUrl,
      'type': type.toPromotionString(),
      'minimumOrderValue': minimumOrderValue,
      'maximumDiscountValue': maximumDiscountValue,
      'startTime': startTime,
      'endTime': endTime,
      'quantity': quantity,
      'usedQuantity': usedQuantity,
      'isDeleted': isDeleted,
    };
  }

  factory Promotion.fromMap(Map<String, dynamic> map) {
    switch ((map['type'] as String).toPromotion()) {
      case PromotionType.freeShipping:
        return FreeShippingPromotion.fromMap(map);
      case PromotionType.percentage:
        return PercentagePromotion.fromMap(map);
      case PromotionType.fixedAmount:
        return FixedAmountPromotion.fromMap(map);
      default:
        return FreeShippingPromotion.fromMap(map);
    }
  }

  factory Promotion.create({
    required PromotionType type,
    required String id,
    required String code,
    required String content,
    double? minimumOrderValue,
    double? maximumDiscountValue,
    required String imgUrl,
    required DateTime startTime,
    required DateTime endTime,
    required int? quantity,
    required int usedQuantity,
    required double discountAmount, // represent for percentage or fixed amount and 0 for free shipping
    required bool isDeleted,
  }) {
    switch (type) {
      case PromotionType.freeShipping:
        return FreeShippingPromotion(
          id: id,
          code: code,
          content: content,
          imgUrl: imgUrl,
          type: type,
          maximumDiscountValue: maximumDiscountValue,
          minimumOrderValue: minimumOrderValue,
          startTime: startTime,
          endTime: endTime,
          quantity: quantity,
          usedQuantity: usedQuantity,
          isDeleted: isDeleted,
        );
      case PromotionType.percentage:
        return PercentagePromotion(
          id: id,
          code: code,
          content: content,
          imgUrl: imgUrl,
          type: type,
          maximumDiscountValue: maximumDiscountValue,
          minimumOrderValue: minimumOrderValue,
          startTime: startTime,
          endTime: endTime,
          quantity: quantity,
          usedQuantity: usedQuantity,
          percentage: discountAmount.toInt(),
          isDeleted: isDeleted,
        );
      case PromotionType.fixedAmount:
        return FixedAmountPromotion(
          id: id,
          code: code,
          content: content,
          imgUrl: imgUrl,
          type: type,
          maximumDiscountValue: maximumDiscountValue,
          minimumOrderValue: minimumOrderValue,
          startTime: startTime,
          endTime: endTime,
          quantity: quantity,
          usedQuantity: usedQuantity,
          amount: discountAmount.toDouble(),
          isDeleted: isDeleted,
        );
      default:
        return FreeShippingPromotion(
          id: id,
          code: code,
          content: content,
          imgUrl: imgUrl,
          type: type,
          maximumDiscountValue: maximumDiscountValue,
          minimumOrderValue: minimumOrderValue,
          startTime: startTime,
          endTime: endTime,
          quantity: quantity,
          usedQuantity: usedQuantity,
          isDeleted: isDeleted,
        );
    }
  }

  String toJson() => json.encode(toMap());

  factory Promotion.fromJson(String source) => Promotion.fromMap(json.decode(source) as Map<String, dynamic>);

  Promotion copyWith({
    String? id,
    String? code,
    String? content,
    String? imgUrl,
    PromotionType? type,
    double? minimumOrderValue,
    double? maximumDiscountValue,
    DateTime? startTime,
    DateTime? endTime,
    int? quantity,
    int? usedQuantity,
    bool? isDeleted,
  }) {
    return Promotion(
      id: id ?? this.id,
      code: code ?? this.code,
      content: content ?? this.content,
      imgUrl: imgUrl ?? this.imgUrl,
      type: type ?? this.type,
      minimumOrderValue: minimumOrderValue ?? this.minimumOrderValue,
      maximumDiscountValue: maximumDiscountValue ?? this.maximumDiscountValue,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      quantity: quantity ?? this.quantity,
      usedQuantity: usedQuantity ?? this.usedQuantity,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  double get amount => 0;
  String get amountString => "";
}
