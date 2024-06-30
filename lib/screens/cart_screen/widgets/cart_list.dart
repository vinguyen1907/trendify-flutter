import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartList extends StatelessWidget {
  final EdgeInsets? padding;
  const CartList({
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartError) {
            return const Center(
              child: Text("Something went wrong."),
            );
          } else if (state is CartLoaded) {
            if (state.cart.cartItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppAssets.imgCartEmpty,
                      height: 120,
                    ),
                    const SizedBox(height: 20),
                    Text("Your cart is empty.", style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              );
            }
            return ListView.builder(
                padding: padding,
                itemCount: state.cart.cartItems.length,
                itemBuilder: (_, index) {
                  return CartItemWidget(
                    cartItem: state.cart.cartItems[index],
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
