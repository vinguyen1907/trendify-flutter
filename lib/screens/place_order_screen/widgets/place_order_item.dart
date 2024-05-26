import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:flutter/material.dart';

class PlaceOrderItem extends StatelessWidget {
  final CartItem cartItem;

  const PlaceOrderItem({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryBackground(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: cartItem.product?.imageUrls.first ?? "",
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (cartItem.product != null) ...[
Text(
                    cartItem.product!.name,
                  style: AppStyles.labelLarge,
                ),
                Text(
                    cartItem.product!.brand,
                  style: AppStyles.bodyLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        (cartItem.product!.price * (cartItem.quantity ?? 0))
                          .toPriceString(),
                      style: AppStyles.headlineLarge,
                    ),
                  ],
                )
                ]
                
              ],
            ),
          ),
          // const Spacer(),
        ],
      ),
    );
  }
}
