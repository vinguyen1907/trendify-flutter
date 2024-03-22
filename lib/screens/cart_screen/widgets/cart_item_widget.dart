import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/common_widgets/color_dot_widget.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:ecommerce_app/screens/detail_product_screen/detail_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final double? imageHeight;
  final double? imageWidth;
  final bool isAdjustable;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    this.imageHeight,
    this.imageWidth,
    this.isAdjustable = true,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.15,
          children: [
            SlidableAction(
              autoClose: true,
              onPressed: (context) {
                context
                    .read<CartBloc>()
                    .add(RemoveItem(cartItemId: cartItem.id));
              },
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => _navigateToProductDetailsScreen(context),
          child: PrimaryBackground(
            margin: const EdgeInsets.all(0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    cartItem.product.imgUrl,
                    height: imageHeight ?? size.width * 0.21,
                    width: imageWidth ?? size.width * 0.21,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        cartItem.product.name,
                        style: AppStyles.labelLarge,
                      ),
                      Text(
                        cartItem.product.brand,
                        style: AppStyles.bodyLarge,
                      ),
                      Row(
                        children: [
                          Text("Size: ${cartItem.size} - Color: ",
                              style: AppStyles.bodyMedium),
                          ColorDotWidget(color: cartItem.color),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (cartItem.product.price * cartItem.quantity)
                                .toPriceString(),
                            style: AppStyles.headlineLarge,
                          ),
                          if (isAdjustable)
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.greyColor,
                                borderRadius: AppDimensions.circleCorners,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: IconButton(
                                      iconSize: 15,
                                      splashRadius: 5,
                                      onPressed: cartItem.quantity > 1
                                          ? () => context.read<CartBloc>().add(
                                              UpdateItem(
                                                  cartItemId: cartItem.id,
                                                  quantity:
                                                      cartItem.quantity - 1))
                                          : null,
                                      icon: const Icon(Icons.remove),
                                    ),
                                  ),
                                  Text(
                                    cartItem.quantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryColor),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      iconSize: 15,
                                      splashRadius: 5,
                                      onPressed: () {
                                        context.read<CartBloc>().add(UpdateItem(
                                            cartItemId: cartItem.id,
                                            quantity: cartItem.quantity + 1));
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      )
                    ],
                  ),
                ),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToProductDetailsScreen(BuildContext context) {
    Navigator.pushNamed(context, DetailProductScreen.routeName,
        arguments: cartItem.product);
  }
}
