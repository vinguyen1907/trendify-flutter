import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/screens/payment_screen/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderSummary extends StatelessWidget {
  const PlaceOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.defaultPadding, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total price",
                  style: Theme.of(context).textTheme.bodyMedium),
              BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
                builder: (context, state) {
                  return Text(
                    state.totalPrice?.toPriceString() ?? "",
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                },
              )
            ],
          ),
          BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
            builder: (context, state) {
              return MyButton(
                isEnable: state.address != null,
                onPressed: () => _navigateToPaymentScreen(context),
                child: Text("Place Order",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.whiteColor)),
              );
            },
          )
        ],
      ),
    );
  }

  _navigateToPaymentScreen(BuildContext context) {
    Navigator.pushNamed(context, PaymentScreen.routeName);
  }
}
