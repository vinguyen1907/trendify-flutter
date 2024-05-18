// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/models/models.dart';

class OrderTrackingScreenArgs {
  final OrderModel order;
  final OrderProductDetail? orderItem;

  OrderTrackingScreenArgs({
    required this.order,
    this.orderItem,
  });
}
