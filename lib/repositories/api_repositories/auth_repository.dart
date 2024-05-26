import 'package:dio/dio.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/core/error/api_exception.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository implements IAuthRepository {
  final dio = Dio();
  final FlutterSecureStorage secureStorage = GetIt.I.get<FlutterSecureStorage>();
  final SharedPreferences sharedPreferences = GetIt.I.get<SharedPreferences>();

  @override
  Future<void> logOut() async {
    await sharedPreferences.setBool(SharedPreferencesKeys.alreadyAuthenticated, false);
  }

  @override
  Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final response = await dio.post(ApiConstants.loginUrl, data: {
        "email": email,
        "password": password,
      });
      print(response.data);
      final token = response.data["accessToken"];
      print("Token ---- ${token}");
      await secureStorage.write(key: "accessToken", value: token);
    } on DioException catch (e) {
      print("Dio error: $e");
      throw ApiException.fromMap(e.response?.data);
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signUpWithEmailAndPassword({required String name, required String email, required String password}) async {
    try {
      final response = await dio.post(ApiConstants.registerUrl, data: {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": password,
        "role": "CUSTOMER",
      });
      final token = response.data["accessToken"];
      await secureStorage.write(key: "accessToken", value: token);
    } on DioException catch (e) {
      throw ApiException.fromMap(e.response?.data);
    } catch (e) {
      rethrow;
    }
  }
}
