import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/screens/place_order_screen/place_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummarySection extends StatelessWidget {
  final EdgeInsets? margin;

  const SummarySection({
    super.key,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: AppColors.greyTextColor),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return Text(
                      state.cart.totalPrice.toPriceString(),
                      style: Theme.of(context).textTheme.headlineLarge,
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Proceed to Checkout",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                SizedBox(
                  height: 30,
                  width: 30,
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: state is CartLoaded
                              ? () => _navigateToPlaceOrderScreen(context)
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              padding: const EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                          child: MyIcon(
                            icon: AppAssets.icArrowRight,
                            height: 10,
                            width: 10,
                            colorFilter: ColorFilter.mode(
                                Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                BlendMode.srcIn),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _navigateToPlaceOrderScreen(BuildContext context) {
    final cartState = context.read<CartBloc>().state;
    if (cartState is CartLoaded) {
      context
          .read<PlaceOrderBloc>()
          .add(UpdatePrice(cartState.cart.totalPrice));
      Navigator.pushNamed(context, PlaceOrderScreen.routeName);
    }
  }
}
