import 'dart:convert';

import 'package:ecommerce_app/constants/enums/enums.dart';
import 'package:ecommerce_app/extensions/extensions.dart';

import 'promotion.dart';

class FixedAmountPromotion extends Promotion {
  @override
  final double amount;

  FixedAmountPromotion(
      {required super.id,
      required super.code,
      required super.content,
      required super.imgUrl,
      required super.type,
      super.maximumDiscountValue,
      super.minimumOrderValue,
      required super.startTime,
      required super.endTime,
      required super.quantity,
      required super.usedQuantity,
      required super.isDeleted,
      required this.amount});

  @override
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
      'amount': amount,
    };
  }

  factory FixedAmountPromotion.fromMap(Map<String, dynamic> map) {
    return FixedAmountPromotion(
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
      amount: map['amount'].toDouble(),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory FixedAmountPromotion.fromJson(String source) => FixedAmountPromotion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String get amountString => amount.toPriceString();

  @override
  FixedAmountPromotion copyWith({
    double? amount,
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
    return FixedAmountPromotion(
      amount: amount ?? this.amount,
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
}
