import 'package:dio/dio.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class CategoryRepository implements ICategoryRepository {
  final Dio dio = Dio();
  final FlutterSecureStorage secureStorage = GetIt.I.get<FlutterSecureStorage>();

  @override
  Future<List<Category>> fetchCategories() async {
    try {
      final String? token = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $token";
      const String url = ApiConstants.fetchCategoriesUrl;

      final response = await dio.get(url);
      List data = response.data;
      final List<Category> categories = data.map<Category>((e) => Category.fromMap(e)).toList();
      return categories;
    } on DioException catch (e) {
      print("CategoryRepository - fetchCategories dio failed: $e");
      throw ApiException(errorCode: e.response?.statusCode?.toString(), message: e.response?.data["message"]);
    } catch (e) {
      print("CategoryRepository - fetchCategories failed: $e");
      throw Exception(e);
    }
  }

  @override
  Future<int> getProductCount(Category category) {
    // TODO: implement getProductCount
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> fetchProductsInCategory(Category category, {required int page, required int size}) async {
    try {
      final String? token = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $token";
      final String url = ApiConstants.fetchProductsInCategoryUrl.replaceAll("{categoryId}", category.id);

      final response = await dio.get(url);

      Map<String, dynamic> data = response.data;
      final List<Product> products = data['data'].map<Product>((e) => Product.fromMap(e)).toList();
      return products;
    } on DioException catch (e) {
      print("CategoryRepository - fetchProductsInCategory dio failed: $e");
      throw ApiException(errorCode: e.response?.statusCode?.toString(), message: e.response?.data["message"]);
    } catch (e) {
      print("CategoryRepository - fetchProductsInCategory error: $e");
      throw Exception(e);
    }
  }

  @override
  Future<List<Category>> searchCategories(String keyword) async {
    try {
      final String? token = await secureStorage.read(key: "accessToken");
      dio.options.headers["Authorization"] = "Bearer $token";
      final String url = "${ApiConstants.searchCategoriesUrl}?keyword=$keyword";

      final response = await dio.get(url);
      List data = response.data;
      final List<Category> categories = data.map<Category>((e) => Category.fromMap(e)).toList();
      return categories;
    } on DioException catch (e) {
      print("CategoryRepository - fetchCategories dio failed: $e");
      throw ApiException(errorCode: e.response?.statusCode?.toString(), message: e.response?.data["message"]);
    } catch (e) {
      print("CategoryRepository - fetchCategories failed: $e");
      throw Exception(e);
    }
  }
}
