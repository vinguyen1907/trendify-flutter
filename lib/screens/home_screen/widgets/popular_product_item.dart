import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/detail_product_screen/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PopularProductItem extends StatelessWidget {
  const PopularProductItem({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _navigateToDetailProductScreen(context),
        child: Container(
          height: size.height * 0.13,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.2),
                    offset: const Offset(0, 6),
                    spreadRadius: 1,
                    blurRadius: 5)
              ]),
          child: Row(
            children: [
              Container(
                height: size.height * 0.13,
                width: size.height * 0.13,
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: product.imgUrl,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: const Color(0xFFE0E0E0),
                      highlightColor: const Color(0xFFF5F5F5),
                      child: Container(
                        color: Colors.white,
                      ),
                    ), // Shimmer loading placeholder
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error), // Error widget
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.brand,
                          style: AppStyles.labelLarge,
                          maxLines: 1,
                        ),
                        Text(
                          product.name,
                          style: AppStyles.bodyMedium,
                          maxLines: 1,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              product.averageRating.toStringAsFixed(1),
                              style: AppStyles.labelMedium,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Text(
                      product.price.toPriceString(),
                      style: AppStyles.labelLarge,
                    ),
                  )
                ],
              )),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetailProductScreen(BuildContext context) {
    Navigator.pushNamed(context, DetailProductScreen.routeName,
        arguments: product);
  }
}
