import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/product_detail.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';

class ProductRepository implements IProductRepository {
  @override
  Future<List<ProductDetail>> fetchProductDetails(Product product) async {
    try {
      List<ProductDetail> productDetails = [];
      await productsRef.doc(product.id).collection('productDetails').where('stock', isGreaterThan: 0).get().then((value) {
        productDetails.addAll(value.docs.map((e) => ProductDetail.fromMap(e.data())));
      });
      return productDetails;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Product>> fetchRecommendedProducts() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> fetchProductInCategory(Category category) async {
    try {
      List<Product> products = [];
      if (category.name == 'New Arrivals') {
        await productsRef.orderBy('createdAt', descending: true).limit(10).get().then((value) {
          products.addAll(value.docs.map((e) => Product.fromMap(e.data() as Map<String, dynamic>)).toList());
        });
      } else {
        await productsRef.where('categoryId', isEqualTo: category.id).where('isDelete', isEqualTo: false).get().then((value) {
          products.addAll(value.docs.map((e) => Product.fromMap(e.data() as Map<String, dynamic>)).toList());
        });
      }
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Product>> fetchNewArrivals() async {
    try {
      List<Product> products = [];
      await productsRef.orderBy("createdAt", descending: true).where('isDelete', isEqualTo: false).limit(10).get().then((value) {
        products.addAll(value.docs.map((e) => Product.fromMap(e.data() as Map<String, dynamic>)));
      });
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Product>> fetchPopular() async {
    try {
      List<Product> products = [];
      await productsRef.orderBy("reviewCount", descending: true).where('isDelete', isEqualTo: false).limit(10).get().then((value) {
        products.addAll(value.docs.map((e) => Product.fromMap(e.data() as Map<String, dynamic>)));
      });
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Product>> fetchAllProducts() async {
    try {
      List<Product> products = [];
      await productsRef.where('isDelete', isEqualTo: false).get().then((value) async {
        products.addAll(value.docs.map((e) => Product.fromMap(e.data() as Map<String, dynamic>)));
      });
      return products;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Product> fetchProductById(String id) async {
    try {
      final doc = await productsRef.doc(id).get();
      return Product.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      print("Fetch product error: $e");
      throw Exception(e);
    }
  }

  @override
  Stream<bool> checkIsFavorite(String productId) {
    return favoritesRef.where('id', isEqualTo: productId).snapshots().map((querySnapshot) => querySnapshot.docs.isNotEmpty);
  }

  @override
  Future<List<Product>> fetchSimilarProducts(String productId) {
    // TODO: implement fetchSimilarProducts
    throw UnimplementedError();
  }
}
