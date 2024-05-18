import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/review.dart';
import 'package:ecommerce_app/screens/review_screen/widgets/review_item.dart';
import 'package:flutter/material.dart';

class ListReviews extends StatelessWidget {
  const ListReviews({super.key, required this.reviews});
  final List<Review> reviews;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return ReviewItem(
            review: reviews[index],
          );
        },
      ),
    );
  }
}
