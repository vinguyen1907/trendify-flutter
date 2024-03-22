import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/e_wallet_transaction.dart';
import 'package:ecommerce_app/models/payment_information.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class EWalletRepository {
  Future<List<PaymentInformation>> fetchEWalletCards() async {
    try {
      final snapshot = await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("e_wallet_cards")
          .get();
      return snapshot.docs
          .map((doc) => PaymentInformation.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

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
          .collection("e_wallet_cards")
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

  Future<void> addTransaction({required EWalletTransaction transaction}) async {
    try {
      final doc = usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("e_wallet_transactions")
          .doc();
      await doc.set(transaction.copyWith(id: doc.id).toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> fetchTransactions(
      {DocumentSnapshot? lastDocument}) async {
    try {
      late final QuerySnapshot snapshot;
      if (lastDocument == null) {
        snapshot = await usersRef
            .doc(firebaseAuth.currentUser!.uid)
            .collection("e_wallet_transactions")
            .orderBy("createdTime", descending: true)
            .limit(10)
            .get();
        snapshot.docs.forEach((element) {
          print(
              EWalletTransaction.fromMap(element.data() as Map<String, dynamic>)
                  .toMap());
        });
      } else {
        snapshot = await usersRef
            .doc(firebaseAuth.currentUser!.uid)
            .collection("e_wallet_transactions")
            .orderBy("createdTime", descending: true)
            .startAfterDocument(lastDocument)
            .limit(10)
            .get();
      }

      return <String, dynamic>{
        "lastDocument": snapshot.docs.isEmpty ? null : snapshot.docs.last,
        "transactions": snapshot.docs.isEmpty
            ? List<EWalletTransaction>.empty()
            : snapshot.docs
                .map((doc) => EWalletTransaction.fromMap(
                    doc.data() as Map<String, dynamic>))
                .toList()
      };
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> topUp({required TopUpTransaction topUpTransaction}) async {
    try {
      await addTransaction(transaction: topUpTransaction);
      // increase balance
      await usersRef.doc(firebaseAuth.currentUser!.uid).update(
          {"eWalletBalance": FieldValue.increment(topUpTransaction.amount)});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> payOrder(
      {required PaymentTransaction paymentTransaction}) async {
    try {
      await addTransaction(transaction: paymentTransaction);
      // decrease balance
      await usersRef.doc(firebaseAuth.currentUser!.uid).update(
          {"eWalletBalance": FieldValue.increment(-paymentTransaction.amount)});
    } catch (e) {
      throw Exception(e);
    }
  }
}
