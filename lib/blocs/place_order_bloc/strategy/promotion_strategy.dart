import '../../../models/models.dart';

abstract class PromotionStrategy {
  double getDiscountAmount();
  double getShippingAfterDiscount();
}

class FreeShippingPromotionStrategy implements PromotionStrategy {
  @override
  double getDiscountAmount() {
    return 0;
  }

  @override
  double getShippingAfterDiscount() {
    return 0;
  }
}

class PercentagePromotionStrategy implements PromotionStrategy {
  final PercentagePromotion promotion;
  final double price;
  final double shippingFee;

  PercentagePromotionStrategy({required this.promotion, required this.price, required this.shippingFee});

  @override
  double getDiscountAmount() {
    return price * promotion.percentage / 100;
  }

  @override
  double getShippingAfterDiscount() {
    return shippingFee;
  }
}

class FixedAmountPromotionStrategy implements PromotionStrategy {
  final PercentagePromotion promotion;
  final double price;
  final double shippingFee;

  FixedAmountPromotionStrategy({required this.promotion, required this.price, required this.shippingFee});

  @override
  double getDiscountAmount() {
    if (price < promotion.amount) {
      return price;
    }

    return promotion.amount;
  }

  @override
  double getShippingAfterDiscount() {
    return shippingFee;
  }
}
