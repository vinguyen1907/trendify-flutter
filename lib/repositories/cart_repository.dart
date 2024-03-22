import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/repositories/product_repository.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class CartRepository {
  Future<Cart> fetchMyCart() async {
    List<CartItem> result = [];

    try {
      final QuerySnapshot snapshot = await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("cart")
          .get();

      for (var doc in snapshot.docs) {
        final Product product =
            await ProductRepository().fetchProductById(doc['productId']);
        result.add(CartItem(
          id: doc.id,
          product: product,
          quantity: doc['quantity'],
          size: doc['size'],
          color: (doc['color'] as String).toColor(),
        ));
      }
    } catch (e) {
      throw Exception(e);
    }

    return Cart(cartItems: result);
  }

  Future<void> addCartItem(
      {required String productId,
      required String size,
      required String color,
      required int quantity}) async {
    try {
      // Check if this product is already in cart (same size, color)
      final QuerySnapshot snapshot = await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("cart")
          .where("productId", isEqualTo: productId)
          .where("color", isEqualTo: color)
          .where("size", isEqualTo: size)
          .get();

      final bool isAlreadyInCart = snapshot.docs.isNotEmpty;
      if (isAlreadyInCart) {
        await usersRef
            .doc(firebaseAuth.currentUser!.uid)
            .collection("cart")
            .doc(snapshot.docs.first.id)
            .update({"quantity": snapshot.docs.first['quantity'] + quantity});
      } else {
        final doc = usersRef
            .doc(firebaseAuth.currentUser!.uid)
            .collection("cart")
            .doc();

        await doc.set({
          "id": doc.id,
          "productId": productId,
          "size": size,
          "color": color,
          "quantity": quantity,
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeCartItem({required String cartItemId}) async {
    try {
      await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("cart")
          .doc(cartItemId)
          .delete();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateCartItem(
      {required String cartItemId, required int quantity}) async {
    try {
      await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("cart")
          .doc(cartItemId)
          .update({"quantity": quantity});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> undoAddCartItem({required ProductLoaded cartItem}) async {
    try {
      await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("cart")
          .where("productId", isEqualTo: cartItem.productId)
          .where("color", isEqualTo: cartItem.colorSelected)
          .where("size", isEqualTo: cartItem.sizeSelected)
          .where("quantity", isEqualTo: cartItem.quantity)
          .get()
          .then((value) async {
        await usersRef
            .doc(firebaseAuth.currentUser!.uid)
            .collection("cart")
            .doc(value.docs.first.id)
            .delete();
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
