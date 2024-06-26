import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/common_widgets/common_widgets.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/extensions/extensions.dart';

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
