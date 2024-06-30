import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/models/review.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class ReviewRepository implements IReviewRepository {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = GetIt.I.get<FlutterSecureStorage>();

  @override
  Future<void> addReview(
      {required BuildContext context,
      required String orderId,
      required String orderItemId,
      required String productId,
      required int rating,
      required String content}) async {
    try {
      print("Start [ReviewRepository.addReview]");

      final userState = context.read<UserBloc>().state;
      if (userState.status == UserStatus.loaded && userState.user != null) {
        final String? token = await secureStorage.read(key: "accessToken");
        dio.options.headers["Authorization"] = "Bearer $token";

        const String url = ApiConstants.addReviewUrl;
        Map<String, dynamic> data = {
          "userId": int.tryParse(userState.user!.id ?? ""),
          "userName": userState.user!.name,
          "avaUrl": userState.user!.imageUrl,
          "productId": int.tryParse(productId),
          "orderId": int.tryParse(orderId),
          "orderItemId": int.tryParse(orderItemId),
          "rate": rating,
          "content": content,
        };
        await dio.post(url, data: jsonEncode(data));

        print("Complete [ReviewRepository.addReview]");
      }
    } on DioException catch (e) {
      debugPrint("Fetch product specs failed: $e");
      throw ApiException(errorCode: e.response?.statusCode?.toString(), message: e.response?.data["message"]);
    } catch (e) {
      debugPrint("Fetch similar products error: $e");
      throw Exception(e);
    }
  }

  @override
  Future<List<Review>> fetchReviews(String productId) async {
    try {
      print("Start [ReviewRepository.fetchReviews]");

      final String? token = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $token";
      final String url = ApiConstants.fetchReviewsUrl.replaceAll("{productId}", productId);

      final response = await dio.get(url);
      print("Response [ReviewRepository.fetchReviews]: $response");

      Map<String, dynamic> data = response.data;
      final List<Review> reviews = data['data'].map<Review>((e) => Review.fromMap(e)).toList();
      return reviews;
    } on DioException catch (e) {
      print("Dio Error [ReviewRepository.fetchReviews]: $e");
      throw ApiException(errorCode: e.response?.statusCode?.toString(), message: e.response?.data["message"]);
    } catch (e) {
      print("Error [ReviewRepository.fetchReviews]: $e");
      throw Exception(e);
    }
  }

  @override
  Future<Review?> fetchReviewByOrderItemId(String orderItemId) async {
    try {
      print("[INFO] Start [ReviewRepository.fetchReviewByOrderItemId]");

      final String? token = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $token";
      final String url = ApiConstants.fetchReviewByOrderItem.replaceAll("{orderItemId}", orderItemId);

      final response = await dio.get(url);
      print("[INFO] Response [ReviewRepository.fetchReviewByOrderItemId]: $response");

      var data = response.data;
      if (data == null || data == "") return null;
      final Review review = Review.fromMap(data);
      return review;
    } on DioException catch (e) {
      print("[ERROR]Dio Error [ReviewRepository.fetchReviewByOrderItemId]: $e");
      throw ApiException(errorCode: e.response?.statusCode?.toString(), message: e.response?.data["message"]);
    } catch (e) {
      print("[ERROR] [ReviewRepository.fetchReviewByOrderItemId]: $e");
      throw Exception(e);
    }
  }
}
