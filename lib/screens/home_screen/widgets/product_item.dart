import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'package:ecommerce_app/extensions/extensions.dart';
import 'package:ecommerce_app/repositories/favorite_repository.dart';
import 'package:ecommerce_app/repositories/product_repository.dart';

import '../../../common_widgets/common_widgets.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';
import '../../screens.dart';

class ProductItem extends StatelessWidget {
  ProductItem({
    super.key,
    required this.product,
    this.imageHeight,
    this.imageWidth,
  });

  final Product product;
  double? imageHeight;
  double? imageWidth;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    imageHeight ??= (size.width - 2 * AppDimensions.defaultPadding - 10) / 2 * 1.6 * 7 / 10;
    imageWidth ??= imageHeight;

    return GestureDetector(
      onTap: () => _onProductItemPressed(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            // height: heightItem,
            // width: heightItem,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CachedNetworkImage(
                  height: imageHeight,
                  width: imageWidth,
                  imageUrl: product.imageUrls.first,
                  fit: BoxFit.fitWidth,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
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
                      final bool isFavorite = snapshot.data ?? false;
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MyIconButton(
                          size: 30,
                          color: isFavorite ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.secondaryContainer,
                          onPressed: () async {
                            if (isFavorite) {
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
                      return const SizedBox();
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
                  product.name,
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.brand,
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

  void _onProductItemPressed(BuildContext context) {
    context.read<UserBloc>().add(ProductClicked(product: product));
    Navigator.pushNamed(context, DetailProductScreen.routeName, arguments: product);
  }
}
