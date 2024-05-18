import 'dart:convert';

import 'package:ecommerce_app/constants/enums/enums.dart';
import 'package:ecommerce_app/extensions/extensions.dart';

import 'promotion_models.dart';

class PercentagePromotion extends Promotion {
  final int percentage;

  PercentagePromotion({
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
    required this.percentage,
  });

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
      'percentage': percentage,
    };
  }

  factory PercentagePromotion.fromMap(Map<String, dynamic> map) {
    return PercentagePromotion(
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
      percentage: map['percentage'] as int,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory PercentagePromotion.fromJson(String source) => PercentagePromotion.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String get amountString => "$percentage%";

  @override
  double get amount => percentage.toDouble();

  @override
  PercentagePromotion copyWith({
    int? percentage,
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
    return PercentagePromotion(
      percentage: percentage ?? this.percentage,
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
