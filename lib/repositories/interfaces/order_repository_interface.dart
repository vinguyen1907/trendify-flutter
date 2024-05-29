import 'package:ecommerce_app/models/models.dart';

abstract class IOrderRepository {
  Future<List<OrderModel>> fetchMyOrders({required bool isCompleted});
  Future<List<OrderProductDetail>> fetchOrderItems({required String orderId});
  Future<String> addOrder({required OrderModel order, required List<CartItem> items, required Promotion? promotion});
}
