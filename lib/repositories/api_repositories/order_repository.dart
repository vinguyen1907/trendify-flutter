import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
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
            "subtotal": order.orderSummary?.amount,
            "shippingFee": order.orderSummary?.shipping,
            "promotionDiscount": order.orderSummary?.promotionDiscount,
            "totalPrice": order.orderSummary?.total,
            "paymentMethod": order.paymentMethod,
            "isPaid": order.isPaid,
            "shippingAddress": order.address != null
                ? {
                    "recipientName": order.address!.recipientName,
                    "street": order.address!.street,
                    "city": order.address!.city,
                    "state": order.address!.state,
                    "country": order.address!.country,
                    "zipCode": order.address!.zipCode,
                    "countryCallingCode": order.address!.countryCallingCode,
                    "phoneNumber": order.address!.phoneNumber,
                    "latitude": order.address!.latitude,
                    "longitude": order.address!.longitude,
                  }
                : null,
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
      print("OrderRepository - addOrder error: $e");
      throw Exception(e);
    }
  }

  @override
  Future<List<OrderModel>> fetchMyOrders({required bool isCompleted}) async {
    try {
      print("[OrderRepository] Start Fetching orders: isCompleted: $isCompleted");

      final String? token = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $token";
      final String url = isCompleted ? ApiConstants.fetchCompletedOrders : ApiConstants.fetchOngoingOrders;

      final response = await dio.get(url);
      print("Response: $response");

      List<dynamic> data = response.data;
      final List<OrderModel> orders = data.map<OrderModel>((e) => OrderModel.fromMap(e)).toList();
      return orders;
    } on DioException catch (e) {
      debugPrint("Fetch product specs failed: $e");
      throw ApiException(errorCode: e.response?.statusCode?.toString(), message: e.response?.data["message"]);
    } catch (e) {
      debugPrint("Fetch similar products error: $e");
      throw Exception(e);
    }
  }

  @override
  Future<List<OrderProductDetail>> fetchOrderItems({required String orderId}) async {
    try {
      final String? token = await secureStorage.read(key: SharedPreferencesKeys.accessToken);
      if (token == null) {
        throw Exception("Token is null");
      }
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(ApiConstants.fetchOrderDetailsUrl.replaceAll("{orderId}", orderId));
      print("Response: $response");
      List data = response.data;
      final orderItems = data.map((e) => OrderProductDetail.fromMap(e)).toList();
      return orderItems;
    } catch (e) {
      debugPrint("Place order error: $e");
      throw Exception(e);
    }
  }
}
