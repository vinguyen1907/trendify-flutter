import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({super.key, required this.products, required this.productCount});
  final List<Product> products;
  final int productCount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1 / 1.6, crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
        itemCount: productCount,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ProductItem(
            product: products[index],
          );
        },
      ),
    );
  }
}
