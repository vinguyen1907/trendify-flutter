import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/constants/firebase_constants.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';

class CategoryRepository implements ICategoryRepository {
  @override
  Future<List<Category>> fetchCategories() async {
    try {
      List<Category> categories = [];
      await categoriesRef
          .where('isDelete', isEqualTo: false)
          .get()
          .then((value) {
        categories.addAll(value.docs
            .map((e) => Category.fromMap(e.data() as Map<String, dynamic>)));
      });
      return categories;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<int> getProductCount(Category category) async {
    try {
      int quantity = 0;
      if (category.name == 'New Arrivals') {
        quantity = 10;
      } else {
        await productsRef
            .where('categoryId', isEqualTo: category.id)
            .get()
            .then((value) {
          quantity = value.docs.length;
        });
      }
      return quantity;
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<List<Product>> fetchProductsInCategory(Category category, {required int page, required int size}) {
    // TODO: implement fetchProductsInCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> searchCategories(String keyword) {
    // TODO: implement searchCategories
    throw UnimplementedError();
  }
}
