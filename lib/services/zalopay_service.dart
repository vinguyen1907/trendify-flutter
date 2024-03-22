import 'package:ecommerce_app/config/app_config.dart';
import 'package:ecommerce_app/config/zalopay_config.dart';
import 'package:ecommerce_app/constants/app_constants.dart';
import 'package:ecommerce_app/models/create_order_response.dart';
import 'package:ecommerce_app/screens/order_processing_screen/order_processing_screen.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:sprintf/sprintf.dart';

class ZaloPayService {
  Future<CreateOrderResponse?> createOrderZaloPay(int price) async {
    final utils = Utils();
    Map<String, String>? header = {};
    header["Content-Type"] = "application/x-www-form-urlencoded";

    var body = {};
    body["app_id"] = ZaloPayConfig.appId;
    body["app_user"] = ZaloPayConfig.appUser;
    body["app_time"] = DateTime.now().millisecondsSinceEpoch.toString();
    body["amount"] = price.toStringAsFixed(0);
    body["app_trans_id"] = utils.getAppTransId();
    body["embed_data"] = "{}";
    body["item"] = "[]";
    body["bank_code"] = utils.getBankCode();
    body["description"] = utils.getDescription(body["app_trans_id"]!);

    var dataGetMac = sprintf("%s|%s|%s|%s|%s|%s|%s", [
      body["app_id"],
      body["app_trans_id"],
      body["app_user"],
      body["amount"],
      body["app_time"],
      body["embed_data"],
      body["item"]
    ]);
    body["mac"] = utils.getMacCreateOrder(dataGetMac);
    // print("mac: ${body["mac"]}");

    http.Response response = await http.post(
      Uri.parse('https://sb-openapi.zalopay.vn/v2/create'),
      headers: header,
      body: body,
    );

    // print("body_request: $body");
    if (response.statusCode != 200) {
      return null;
    }

    var data = jsonDecode(response.body);
    // print("data_response: $data}");

    return CreateOrderResponse.fromJson(data);
  }

  Future<void> createZaloPayPayment(
      {required BuildContext context, required double price}) async {
    String zpTransToken = "";

    final tokenResult = await ZaloPayService().createOrderZaloPay(
        (price * AppConstants.usdToVndExchangeRate).toInt());
    if (tokenResult != null) {
      zpTransToken = tokenResult.zpTransToken;
    }
    final String result = await AppConfig.platform
        .invokeMethod('payOrder', {"zptoken": zpTransToken});
    switch (result) {
      case "Payment Success":
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            OrderProcessingScreen.routeName,
            (route) => route.isFirst,
          );
        }
      case "User Canceled":
        if (context.mounted) {
          Utils.showSnackBar(
              context: context, message: "Payment not successfully");
        }
        break;
      case "Payment failed":
        if (context.mounted) {
          Utils.showSnackBar(
              context: context, message: "Payment failed. Please try again");
        }
        break;
      default:
        break;
    }
  }
}
