import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/models/review.dart';
import 'package:ecommerce_app/repositories/product_repository.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewRepository {
  Future<List<Review>> fetchReviews(String productId) async {
    try {
      List<Review> reviews = [];
      await productsRef
          .doc(productId)
          .collection('reviews')
          .get()
          .then((value) {
        reviews.addAll(value.docs.map((e) => Review.fromMap(e.data())));
      });
      return reviews;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addReview(
      {required BuildContext context,
      required String orderId,
      required String orderItemId,
      required String productId,
      required int rating,
      required String content}) async {
    try {
      final userState = context.read<UserBloc>().state;
      if (userState is UserLoaded) {
        final doc = productsRef.doc(productId).collection('reviews').doc();
        final review = Review(
            id: doc.id,
            userId: firebaseAuth.currentUser!.uid,
            nameUser: userState.user.name,
            avaUrl: userState.user.imageUrl,
            rate: rating,
            content: content,
            createdAt: DateTime.now());
        await doc.set(review.toMap());

        // update review in order doc
        await ordersRef
            .doc(orderId)
            .collection("items")
            .doc(orderItemId)
            .update({'review': review.toMap()});

        // update average rating and review count in product doc
        final product = await ProductRepository().fetchProductById(productId);
        final newAverageRating =
            (product.averageRating * product.reviewCount + rating) /
                (product.reviewCount + 1);
        await productsRef.doc(productId).update({
          'averageRating': newAverageRating,
          'reviewCount': product.reviewCount + 1,
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
