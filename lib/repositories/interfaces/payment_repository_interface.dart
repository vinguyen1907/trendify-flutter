import 'package:ecommerce_app/models/models.dart';

abstract class IPaymentRepository {
  Future<void> addPaymentCard({
    required String cardNumber,
    required String holderName,
    required String expiryDate,
    required String cvvCode,
    required String cardType,
  });
  Future<List<PaymentInformation>> fetchPaymentCards();
}
