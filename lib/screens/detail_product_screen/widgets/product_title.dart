import 'package:ecommerce_app/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.brand,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Flexible(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                final currentState = state as ProductLoaded;
                return Container(
                  height: size.height * 0.05,
                  width: size.width * 0.25,
                  decoration: BoxDecoration(
                      color: AppColors.greyColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            context
                                .read<ProductBloc>()
                                .add(const DecreaseQuantity());
                          },
                          child: Icon(
                            Icons.remove,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          )),
                      Text(
                        currentState.quantity.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
                      ),
                      GestureDetector(
                          onTap: () {
                            context
                                .read<ProductBloc>()
                                .add(const IncreaseQuantity());
                          },
                          child: Icon(Icons.add,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer)),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
