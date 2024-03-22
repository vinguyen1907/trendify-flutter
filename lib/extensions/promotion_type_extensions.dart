import 'package:ecommerce_app/models/promotion.dart';

extension PromotionTypeExt on PromotionType {
  String toPromotionString() {
    switch (this) {
      case PromotionType.freeShipping:
        return "free_shipping";
      case PromotionType.percentage:
        return "percentage";
      case PromotionType.fixedAmount:
        return "fixed_amount";
      default:
        return "free_shipping";
    }
  }
}
