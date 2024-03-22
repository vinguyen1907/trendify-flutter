import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/place_order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderProductItems extends StatelessWidget {
  const PlaceOrderProductItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return ListView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.cart.itemsCount,
              itemBuilder: (_, index) {
                return PlaceOrderItem(
                  cartItem: state.cart.cartItems[index],
                );
              });
        }
        return const SizedBox();
      },
    );
  }
}
