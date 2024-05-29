import 'package:dio/dio.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class AddressRepository implements IAddressRepository {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = GetIt.I.get<FlutterSecureStorage>();

  @override
  Future<void> addShippingAddress({required ShippingAddress address, bool? setAsDefault}) async {
    try {
      final String? token = await secureStorage.read(key: SharedPreferencesKeys.accessToken);
      if (token == null) {
        throw Exception("Token is null");
      }
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.post(ApiConstants.shippingAddressUrl, data: address.toJson());
      print("Response: $response");
    } catch (e) {
      debugPrint("Add shipping address error: $e");
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteAddress({required String addressId}) {
    // TODO: implement deleteAddress
    throw UnimplementedError();
  }

  @override
  Future<List<ShippingAddress>> fetchShippingAddresses() async {
    try {
      final String? token = await secureStorage.read(key: SharedPreferencesKeys.accessToken);
      if (token == null) {
        throw Exception("Token is null");
      }
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(ApiConstants.shippingAddressUrl);
      print("Response: $response");
      List data = response.data;
      final List<ShippingAddress> shippingAddresses = data.map((e) => ShippingAddress.fromMap(e)).toList();
      return shippingAddresses;
    } catch (e) {
      debugPrint("Fetch shipping addresses error: $e");
      throw Exception(e);
    }
  }

  @override
  Future<void> updateDefaultShippingAddress({required ShippingAddress address}) {
    // TODO: implement updateDefaultShippingAddress
    throw UnimplementedError();
  }

  @override
  Future<void> updateShippingAddress({required ShippingAddress address, bool? setAsDefault}) {
    // TODO: implement updateShippingAddress
    throw UnimplementedError();
  }
}
