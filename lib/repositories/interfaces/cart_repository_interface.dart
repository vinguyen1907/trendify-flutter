import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/models/models.dart';

abstract class ICartRepository {
  void connect(Function(Cart) updateCart);
  Future<void> addCartItem({required String productId, required String size, required String color, required int quantity});
  Future<void> removeCartItem({required String cartItemId});
  Future<void> updateCartItem({required String cartItemId, required int quantity});
  Future<void> undoAddCartItem({required ProductLoaded cartItem});
  void dispose();
}
