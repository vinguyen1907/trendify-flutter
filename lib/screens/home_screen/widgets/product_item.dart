import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/my_icon_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/repositories/favorite_repository.dart';
import 'package:ecommerce_app/repositories/product_repository.dart';
import 'package:ecommerce_app/screens/detail_product_screen/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightItem = (size.width - 2 * AppDimensions.defaultPadding - 10) / 2 * 1.6 * 7 / 10;
    return GestureDetector(
      onTap: () => _navigateToDetailProductScreen(context),
      child: Column(
        children: [
          SizedBox(
            height: heightItem,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CachedNetworkImage(
                  imageUrl: product.imgUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: const Color(0xFFE0E0E0),
                    highlightColor: const Color(0xFFF5F5F5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                    ),
                  ), // Loading placeholder
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)), // Error widget
                ),
                StreamBuilder(
                  stream: ProductRepository().checkIsFavorite(product.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    } else if (snapshot.hasData) {
                      final bool isFavorite = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyIconButton(
                          size: 30,
                          color: isFavorite ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.secondaryContainer,
                          onPressed: () async {
                            if (snapshot.data!) {
                              await FavoriteRepository().removeFavoriteProduct(product.id);
                            } else {
                              await FavoriteRepository().addFavoriteProduct(product);
                            }
                          },
                          icon: MyIcon(
                            icon: AppAssets.icHeartOutline,
                            width: 26,
                            colorFilter:
                                ColorFilter.mode(isFavorite ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, BlendMode.srcIn),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  product.brand,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  product.price.toPriceString(),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Color(0xFF2B75F8)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetailProductScreen(BuildContext context) {
    Navigator.pushNamed(context, DetailProductScreen.routeName, arguments: product);
  }
}
