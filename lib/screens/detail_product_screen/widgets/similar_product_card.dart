import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/extensions/extensions.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SimilarProductCard extends StatelessWidget {
  const SimilarProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
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
                  height: 120,
                  width: 120,
                  imageUrl: product.imageUrls.first,
                  fit: BoxFit.contain,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                // TODO: Recover this
                // StreamBuilder(
                //   stream: ProductRepository().checkIsFavorite(product.id),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const SizedBox();
                //     } else if (snapshot.hasData) {
                //       final bool isFavorite = snapshot.data ?? false;
                //       return Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: MyIconButton(
                //           size: 30,
                //           color: isFavorite ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.secondaryContainer,
                //           onPressed: () async {
                //             if (isFavorite) {
                //               await FavoriteRepository().removeFavoriteProduct(product.id);
                //             } else {
                //               await FavoriteRepository().addFavoriteProduct(product);
                //             }
                //           },
                //           icon: MyIcon(
                //             icon: AppAssets.icHeartOutline,
                //             width: 26,
                //             colorFilter:
                //                 ColorFilter.mode(isFavorite ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, BlendMode.srcIn),
                //           ),
                //         ),
                //       );
                //     } else {
                //       return const SizedBox();
                //     }
                //   },
                // )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  product.name,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                product.brand,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              Text(
                product.price.toPriceString(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xFF2B75F8)),
              ),
            ],
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
