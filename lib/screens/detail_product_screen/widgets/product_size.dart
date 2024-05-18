import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/color_bar.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/size_bar.dart';
import 'package:flutter/material.dart';

class ProductSize extends StatelessWidget {
  const ProductSize({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "Size",
            style: AppStyles.headlineMedium,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [SizeBar(), ColorBar()],
        ),
      ],
    );
  }
}
