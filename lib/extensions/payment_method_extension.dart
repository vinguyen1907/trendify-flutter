import 'package:ecommerce_app/repositories/payment_methods_repository.dart';

extension PaymentMethodExtension on PaymentMethods {
  String get name {
    return paymentMethodsResource[this]?.name ?? "";
  }

  String get code {
    return paymentMethodsResource[this]?.code ?? "";
  }

  String get imageAsset {
    return paymentMethodsResource[this]?.imageAsset ?? "";
  }
}
