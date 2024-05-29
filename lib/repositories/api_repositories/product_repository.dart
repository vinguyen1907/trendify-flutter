import 'package:dio/dio.dart';
import 'package:ecommerce_app/constants/api_constants.dart';
import 'package:ecommerce_app/constants/shared_preferences_keys.dart';
import 'package:ecommerce_app/core/error/api_exception.dart';
import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/product_detail.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class ProductRepository implements IProductRepository {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = GetIt.I.get<FlutterSecureStorage>();

  @override
  Stream<bool> checkIsFavorite(String productId) {
    // TODO: implement checkIsFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> fetchAllProducts() {
    // TODO: implement fetchAllProducts
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> fetchNewArrivals() {
    // TODO: implement fetchNewArrivals
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> fetchPopular() {
    // TODO: implement fetchPopular
    throw UnimplementedError();
  }

  @override
  Future<Product> fetchProductById(String id) async {
    try {
      final String? token = await secureStorage.read(key: SharedPreferencesKeys.accessToken);
      if (token == null) {
        throw Exception("Token is null");
      }
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get("${ApiConstants.productsUrl}/$id");
      print("Response: $response");
      final Product product = Product.fromMap(response.data);
      return product;
    } catch (e) {
      debugPrint("Fetch recommended products error: $e");
      throw Exception(e);
    }
  }

  @override
  Future<List<ProductDetail>> fetchProductDetails(Product product) async {
    try {
      final String? token = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(
        ApiConstants.fetchProductSpecs.replaceAll("{productId}", product.id),
      );
      final List<ProductDetail> productDetails = response.data.map<ProductDetail>((e) => ProductDetail.fromMap(e)).toList();
      return productDetails;
    } on DioException catch (e) {
      debugPrint("Fetch product specs failed: $e");
      throw ApiException(errorCode: e.response?.statusCode?.toString(), message: e.response?.data["message"]);
    }
  }

  @override
  Future<List<Product>> fetchProductInCategory(Category category) {
    // TODO: implement fetchProductInCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> fetchRecommendedProducts() async {
    try {
      final String? token = await secureStorage.read(key: SharedPreferencesKeys.accessToken);
      if (token == null) {
        throw Exception("Token is null");
      }
      dio.options.headers["Authorization"] = "Bearer $token";
      final response = await dio.get(ApiConstants.userGetRecommendedProductsUrl);
      final List<Product> products = response.data.map<Product>((e) => Product.fromMap(e)).toList();
      return products;
    } catch (e) {
      debugPrint("Fetch recommended products error: $e");
      throw Exception(e);
    }
  }

  @override
  Future<List<Product>> fetchSimilarProducts(String productCode) async {
    try {
      final String? token = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $token";
      final String url = ApiConstants.fetchSimilarProducts.replaceAll("{productCode}", productCode);
      final response = await dio.get(url);
      Map<String, dynamic> data = response.data;
      final List<Product> products = data['data'].map<Product>((e) => Product.fromMap(e)).toList();
      return products;
    } on DioException catch (e) {
      debugPrint("Fetch product specs failed: $e");
      throw ApiException(errorCode: e.response?.statusCode?.toString(), message: e.response?.data["message"]);
    } catch (e) {
      debugPrint("Fetch similar products error: $e");
      throw Exception(e);
    }
  }
}
