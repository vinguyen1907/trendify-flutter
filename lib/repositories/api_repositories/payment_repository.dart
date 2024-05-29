import 'package:dio/dio.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/models/payment_information.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class PaymentRepository implements IPaymentRepository {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = GetIt.I.get<FlutterSecureStorage>();

  @override
  Future<void> addPaymentCard(
      {required String cardNumber, required String holderName, required String expiryDate, required String cvvCode, required String cardType}) async {
    // TODO: implement fetchPaymentCards
    throw UnimplementedError();
  }

  @override
  Future<List<PaymentInformation>> fetchPaymentCards() async {
    try {
      final String? token = await secureStorage.read(key: SharedPreferencesKeys.accessToken);
      if (token == null) {
        throw Exception("Token is null");
      }
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(ApiConstants.paymentInfosUrl);
      print("Response: $response");
      List data = response.data;
      final cards = data.map((e) => PaymentInformation.fromMap(e)).toList();
      return cards;
    } catch (e) {
      debugPrint("Fetch recommended products error: $e");
      throw Exception(e);
    }
  }
}
