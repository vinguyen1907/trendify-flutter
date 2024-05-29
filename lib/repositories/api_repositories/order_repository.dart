import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/extensions/extensions.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/models/promotion_models/promotion.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class OrderRepository implements IOrderRepository {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = GetIt.I.get<FlutterSecureStorage>();

  @override
  Future<String> addOrder({required OrderModel order, required List<CartItem> items, required Promotion? promotion}) async {
    try {
      final String? token = await secureStorage.read(key: SharedPreferencesKeys.accessToken);
      if (token == null) {
        throw Exception("Token is null");
      }
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.post(ApiConstants.orderUrl,
          data: jsonEncode({
            "orderNumber": order.orderNumber,
            "customerId": order.customerId,
            "subtotal": order.orderSummary.amount,
            "shippingFee": order.orderSummary.shipping,
            "promotionDiscount": order.orderSummary.promotionDiscount,
            "totalPrice": order.orderSummary.total,
            "paymentMethod": order.paymentMethod,
            "isPaid": order.isPaid,
            "shippingAddress": {
              "recipientName": order.address.recipientName,
              "street": order.address.street,
              "city": order.address.city,
              "state": order.address.state,
              "country": order.address.country,
              "zipCode": order.address.zipCode,
              "countryCallingCode": order.address.countryCallingCode,
              "phoneNumber": order.address.phoneNumber,
              "latitude": order.address.latitude,
              "longitude": order.address.longitude,
            },
            "orderItems": items
                .map((e) => {
                      "productId": e.product?.id,
                      "productName": e.product?.name,
                      "productPrice": e.product?.price,
                      "productImgUrl": e.product?.imageUrls.first,
                      "productBrand": e.product?.brand,
                      "color": e.color?.toColorCode(),
                      "size": e.size,
                      "quantity": e.quantity
                    })
                .toList(),
          }));
      print("Response: $response");
      final String orderId = response.data["orderId"]?.toString() ?? "";
      return orderId;
    } catch (e) {
      debugPrint("Place order error: $e");
      throw Exception(e);
    }
  }

  @override
  Future<List<OrderModel>> fetchMyOrders({required bool isCompleted}) {
    // TODO: implement fetchMyOrders
    throw UnimplementedError();
  }

  @override
  Future<List<OrderProductDetail>> fetchOrderItems({required String orderId}) {
    // TODO: implement fetchOrderItems
    throw UnimplementedError();
  }
}
