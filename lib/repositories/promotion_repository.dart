import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/promotion_models/promotion.dart';
import 'package:ecommerce_app/constants/constants.dart';

class PromotionRepository {
  Future<List<Promotion>> fetchMyPromotions() async {
    try {
      List<Promotion> promotions = [];

      final QuerySnapshot snapshot = await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("promotions")
          .where("endTime", isGreaterThan: Timestamp.fromDate(DateTime.now()))
          .get();

      promotions.addAll(snapshot.docs.map((e) => Promotion.fromMap(e.data() as Map<String, dynamic>)));
      promotions.removeWhere((element) => element.startTime.isAfter(DateTime.now()));
      promotions.removeWhere((element) => element.quantity != null && element.usedQuantity >= element.quantity!);

      return promotions;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addToMyPromotions({required Promotion promotion}) async {
    try {
      final doc = usersRef.doc(firebaseAuth.currentUser!.uid).collection("promotions").doc();
      promotion = promotion;
      await doc.set(promotion.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Promotion>> fetchValidPromotions() async {
    List<Promotion> promotions = [];
    try {
      final snapshot = await promotionsRef
          // .where("endTime", isGreaterThan: DateTime.now())
          .get();

      promotions.addAll(snapshot.docs.map((e) => Promotion.fromMap(e.data() as Map<String, dynamic>)));
      // promotions.removeWhere((element) => element.startTime.isAfter(DateTime.now()));
      // promotions.removeWhere((element) => element.quantity != null && element.usedQuantity >= element.quantity!);
      // promotions.removeWhere((element) => element.isDeleted == true);
    } catch (e) {
      print("fetchValidPromotions error: $e");
    }
    return promotions;
  }

  Stream<bool> isPromotionReceived(String promotionCode) {
    return usersRef
        .doc(firebaseAuth.currentUser!.uid)
        .collection("promotions")
        .where('code', isEqualTo: promotionCode)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.isNotEmpty);
  }
}
