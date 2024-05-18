import 'package:ecommerce_app/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/my_outlined_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/add_address_screen/add_address_screen.dart';
import 'package:ecommerce_app/screens/shipping_addresses_screen/widgets/adjustable_address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShippingAddressesScreen extends StatefulWidget {
  const ShippingAddressesScreen({super.key});

  static const String routeName = "shipping-addresses-screen";

  @override
  State<ShippingAddressesScreen> createState() =>
      _ShippingAddressesScreenState();
}

class _ShippingAddressesScreenState extends State<ShippingAddressesScreen> {
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
                        return const SizedBox(height: 20);
                      },
                      itemBuilder: (_, index) {
                        final address = state.addresses[index];
                        return AdjustableAddressCard(address: address);
                      });
                } else if (state is AddressesError) {
                  return Text(state.message);
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
                      style: Theme.of(context).textTheme.labelLarge!,
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
}
