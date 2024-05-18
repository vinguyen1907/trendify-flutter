import 'package:ecommerce_app/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/repositories/favorite_repository.dart';
import 'package:ecommerce_app/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarProduct extends StatelessWidget {
  const BottomBarProduct({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Container(
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: ProductRepository().checkIsFavorite(product.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    } else if (snapshot.hasData) {
                      return GestureDetector(
                        onTap: () async {
                          if (snapshot.data!) {
                            await FavoriteRepository()
                                .removeFavoriteProduct(product.id);
                          } else {
                            await FavoriteRepository()
                                .addFavoriteProduct(product);
                          }
                        },
                        child: Container(
                          height: size.height * 0.07,
                          width: size.height * 0.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.greyColor),
                          child: Center(
                            child: MyIcon(
                              icon: snapshot.data!
                                  ? AppAssets.icHeartBold
                                  : AppAssets.icHeartOutline,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.primaryColor, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                InkWell(
                  onTap: () {
                    context.read<ProductBloc>().add(const AddToCart());
                  },
                  child: Container(
                    height: size.height * 0.07,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        MyIcon(
                            icon: AppAssets.icBag,
                            colorFilter: ColorFilter.mode(
                                Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                BlendMode.srcIn)),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Add to cart",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
