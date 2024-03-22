import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/address_card.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/choose_address_screen/choose_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
      builder: (context, state) {
        final address = state.address;
        if (address != null) {
          return InkWell(
            onTap: () => _navigateToChooseAddressScreen(context),
            child: AddressCard(
                width: size.width - 2 * AppDimensions.defaultPadding,
                address: address),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding),
            child: OutlinedButton(
                onPressed: () => _navigateToChooseAddressScreen(context),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyIcon(
                      icon: AppAssets.icAddAddress,
                      colorFilter: ColorFilter.mode(
                          AppColors.greyTextColor, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Choose Address",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: AppColors.greyTextColor),
                    ),
                  ],
                )),
          );
        }
      },
    );
  }

  _navigateToChooseAddressScreen(BuildContext context) {
    Navigator.pushNamed(context, ChooseAddressScreen.routeName);
  }
}
