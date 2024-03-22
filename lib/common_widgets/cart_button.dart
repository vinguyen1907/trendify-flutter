import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          child: Badge(
            label: Text("${state is CartLoaded ? state.cart.itemsCount : 0}",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer)),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: AppDimensions.circleCorners,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 0),
                      )
                    ]),
                alignment: Alignment.center,
                child: const MyIcon(
                  icon: AppAssets.icShoppingBag,
                  height: 12,
                )),
          ),
        );
      },
    );
  }
}
