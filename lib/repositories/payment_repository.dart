import 'package:ecommerce_app/models/payment_information.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class PaymentRepository {
  Future<void> addPaymentCard({
    required String cardNumber,
    required String holderName,
    required String expiryDate,
    required String cvvCode,
    required String cardType,
  }) async {
    try {
      final doc = usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("payment_cards")
          .doc();
      final PaymentInformation newCard = PaymentInformation(
        id: doc.id,
        holderName: holderName,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cvvCode: cvvCode,
        type: cardType,
      );
      await doc.set(newCard.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PaymentInformation>> fetchPaymentCards() async {
    try {
      final snapshot = await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("payment_cards")
          .get();
      List<PaymentInformation> paymentCards = [];
      for (var element in snapshot.docs) {
        print(element.data());
      }
      paymentCards = snapshot.docs
          .map((e) => PaymentInformation.fromMap(e.data()))
          .toList();
      return paymentCards;
    } catch (e) {
      throw Exception(e);
    }
  }
}
