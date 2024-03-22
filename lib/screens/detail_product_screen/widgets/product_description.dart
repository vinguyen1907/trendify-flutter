import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Description",
            style: AppStyles.headlineMedium,
          ),
        ),
        Text(
          description,
          style: AppStyles.bodyMedium,
        )
      ],
    );
  }
}
