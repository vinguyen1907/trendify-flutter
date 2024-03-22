import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class StatisticsRepository {
  Future<void> updateMonthlySales(
      {required DateTime time, required double orderValue}) async {
    try {
      final docRef = ordersStatisticsDocRef
          .collection("monthly_sales")
          .doc("${time.year}-${time.month}");
      final doc = await docRef.get();
      if (doc.exists) {
        docRef.update({
          "ordersCount": FieldValue.increment(1),
          "revenue": FieldValue.increment(orderValue),
        });
      } else {
        docRef.set({
          "id": "${time.year}-${time.month}",
          "ordersCount": 1,
          "revenue": orderValue,
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateStatistics({required double orderValue}) async {
    ordersStatisticsDocRef.update({
      "ordersCount": FieldValue.increment(1),
      "revenue": FieldValue.increment(orderValue),
    });
  }

  Future<List<OrderModel>> fetchAllOrders() async {
    try {
      final snapshot =
          await ordersRef.orderBy("createdAt", descending: true).get();
      return snapshot.docs
          .map((e) => OrderModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
