import 'package:ecommerce_app/models/models.dart';

abstract class ICategoryRepository {
  Future<List<Category>> fetchCategories();
  Future<List<Category>> searchCategories(String keyword);
  Future<int> getProductCount(Category category);
  Future<List<Product>> fetchProductsInCategory(Category category, {required int page, required int size});
}
