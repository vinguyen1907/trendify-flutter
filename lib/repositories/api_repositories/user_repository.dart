import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/core/error/api_exception.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/models/user_profile.dart';
import 'package:ecommerce_app/repositories/interfaces/user_repository_interface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository implements IUserRepository {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = GetIt.I.get<FlutterSecureStorage>();

  @override
  Future<void> createNewUser({required String id, required String email, required String name}) {
    // TODO: implement createNewUser
    throw UnimplementedError();
  }

  @override
  Future<UserProfile> fetchUser() async {
    try {
      print("Start UserRepository - fetchUser");

      final String? token = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get("${ApiConstants.usersUrl}/user");
      print("Response: $response");
      final user = UserProfile.fromMap(response.data);
      return user;
    } on DioException catch (e) {
      print("UserRepository - fetchUser Dio error: ${e.response}");
      throw ApiException.fromMap(e.response?.data);
    }
  }

  @override
  Future<void> updateDefaultShippingAddress({required ShippingAddress newDefaultAddress}) {
    // TODO: implement updateDefaultShippingAddress
    throw UnimplementedError();
  }

  @override
  Future<void> updateFcmToken(String userId) async {
    try {
      final String? accessToken = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $accessToken";

      final fcmToken = await FirebaseMessaging.instance.getToken();
      print("New FCM token: $fcmToken");
      await dio.patch("${ApiConstants.usersUrl}/user", data: {"fcmToken": fcmToken});
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateUser({String? name, String? gender, int? age, String? email, XFile? image}) async {
    print("Start [UserRepository] - updateUser");

    final String? accessToken = await secureStorage.read(key: "accessToken");
    dio.options.headers["Authorization"] = "Bearer $accessToken";

    // Update user avatar if image is not null
    try {
      if (image != null) {
        print("[UserRepository] - Update user avatar");
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            image.path,
            filename: 'avatar.jpg',
          ),
        });
        dio.put(ApiConstants.updateUserAvatarUrl, data: formData);
      }
    } on DioException catch (e) {
      print("[UserRepository] - update user avatar dio failed: $e");
      throw ApiException(errorCode: e.response?.statusCode?.toString(), message: e.response?.data["message"]);
    } catch (e) {
      print("[UserRepository] - update user avatar error: $e");
      throw Exception(e);
    }

    // Update user information
    try {
      const String url = ApiConstants.updateUserUrl;
      await dio.patch(
        url,
        data: jsonEncode({
          "name": name,
          "gender": gender == "male"
              ? "MALE"
              : gender == "female"
                  ? "FEMALE"
                  : "OTHER",
          "age": age,
        }),
      );
    } on DioException catch (e) {
      print("[UserRepository] - update user info dio failed: $e");
      throw ApiException(errorCode: e.response?.statusCode?.toString(), message: e.response?.data["message"]);
    } catch (e) {
      print("[UserRepository] - update user info error: $e");
      throw Exception(e);
    }
  }

  @override
  Future<void> recordUserClick(Product product) async {
    try {
      final String? token = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $token";
      print("Record click history for product: ${product.code}");
      await dio.post(ApiConstants.recordUserClickUrl, data: {"productId": product.id, "productCode": product.code});
    } on DioException catch (e) {
      print("Record user click failed: ${e.response?.data}");
    }
  }
}
