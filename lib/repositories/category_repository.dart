import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class CategoryRepository {
  Future<List<Category>> fetchCategories() async {
    try {
      List<Category> categories = [];
      await categoriesRef
          .where('isDelete', isEqualTo: false)
          .get()
          .then((value) {
        categories.addAll(value.docs
            .map((e) => Category.fromJson(e.data() as Map<String, dynamic>)));
      });
      return categories;
    } catch (e) {
      throw Exception(e);
    }
  }

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
}
