import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class FavoriteRepository {
  Future<List<Product>> fetchProducts() async {
    try {
      List<Product> products = [];
      await currentUserRef.collection('favorites').get().then((value) {
        products.addAll(value.docs.map((e) => Product.fromMap(e.data())));
      });
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addFavoriteProduct(Product product) async {
    try {
      await currentUserRef
          .collection('favorites')
          .doc(product.id)
          .set(product.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeFavoriteProduct(String productId) async {
    try {
      await currentUserRef.collection('favorites').doc(productId).delete();
    } catch (e) {
      throw Exception(e);
    }
  }
}
