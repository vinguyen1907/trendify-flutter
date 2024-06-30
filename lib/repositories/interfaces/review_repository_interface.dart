import 'package:ecommerce_app/models/models.dart';
import 'package:flutter/material.dart';

abstract class IReviewRepository {
  Future<List<Review>> fetchReviews(String productId);
  Future<void> addReview(
      {required BuildContext context,
      required String orderId,
      required String orderItemId,
      required String productId,
      required int rating,
      required String content});
  Future<Review?> fetchReviewByOrderItemId(String orderItemId);
}
