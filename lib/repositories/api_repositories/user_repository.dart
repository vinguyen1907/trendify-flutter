import 'package:dio/dio.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/core/error/api_exception.dart';
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
      final String? token = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get("${ApiConstants.usersUrl}/user");
      final user = UserProfile.fromMap(response.data);
      return user;
    } on DioException catch (e) {
      print("Erorr: ${e.response?.data}");
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
      await dio.patch("${ApiConstants.usersUrl}/$userId", data: {"fcmToken": fcmToken});
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateUser({String? name, String? gender, int? age, String? email, XFile? image}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
