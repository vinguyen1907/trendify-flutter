import 'package:ecommerce_app/models/cart_item.dart';

class Cart {
  final List<CartItem> cartItems;

  const Cart({required this.cartItems});

  double get totalPrice {
    double total = 0;
    for (var cartItem in cartItems) {
      total += cartItem.product.price * cartItem.quantity;
    }
    return total;
  }

  int get itemsCount {
    return cartItems.length;
  }
}
