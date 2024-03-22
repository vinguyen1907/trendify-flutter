import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/screens/category_screen/widgets/category_item.dart';
import 'package:flutter/material.dart';

class GridViewCategory extends StatelessWidget {
  const GridViewCategory({super.key, required this.categories});
  final List<Category> categories;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.defaultPadding, vertical: 15),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1.2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2),
        itemCount: categories.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CategoryItem(
            category: categories[index],
          );
        },
      ),
    );
  }
}
