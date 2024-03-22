import 'package:ecommerce_app/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/address_card.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/my_outlined_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/screens/add_address_screen/add_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseAddressScreen extends StatefulWidget {
  const ChooseAddressScreen({super.key});

  static const String routeName = "/choose-address-screen";

  @override
  State<ChooseAddressScreen> createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AddressesBloc>().add(LoadAddresses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AddressesBloc, AddressesState>(
              builder: (context, state) {
                if (state is AddressesLoaded) {
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.addresses.length,
                      separatorBuilder: (_, index) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (_, index) {
                        final address = state.addresses[index];
                        return InkWell(
                            onTap: () => _onChooseAddress(
                                context: context, address: address),
                            child: AddressCard(address: address));
                      });
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(height: 30),
            MyOutlinedButton(
                margin: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultPadding),
                onPressed: () => _navigateToAddAddressScreen(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyIcon(icon: AppAssets.icAddRound),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.addNewAddress,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.primaryColor),
                    )
                  ],
                )),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  _navigateToAddAddressScreen(BuildContext context) {
    Navigator.pushNamed(context, AddAddressScreen.routeName);
  }

  _onChooseAddress(
      {required BuildContext context, required ShippingAddress address}) {
    context.read<PlaceOrderBloc>().add(UpdateAddress(address));
    Navigator.pop(context);
  }
}
