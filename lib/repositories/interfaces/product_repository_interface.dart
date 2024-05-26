import 'package:ecommerce_app/models/models.dart';

abstract class IProductRepository {
  Future<List<ProductDetail>> fetchProductDetails(Product product);
  Future<List<Product>> fetchProductInCategory(Category category);
  Future<List<Product>> fetchRecommendedProducts();
  Future<List<Product>> fetchNewArrivals();
  Future<List<Product>> fetchPopular();
  Future<List<Product>> fetchAllProducts();
  Future<Product> fetchProductById(String id);
  Stream<bool> checkIsFavorite(String productId);
  Future<List<Product>> fetchSimilarProducts(String productId);
}
