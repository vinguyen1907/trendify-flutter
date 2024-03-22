import 'package:ecommerce_app/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/screens/add_address_screen/add_address_screen.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/address_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdjustableAddressCard extends StatelessWidget {
  const AdjustableAddressCard({
    super.key,
    required this.address,
  });

  final ShippingAddress address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.15,
          children: [
            SlidableAction(
              autoClose: true,
              onPressed: (context) => _onDeleteAddress(context),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ],
        ),
        child: PrimaryBackground(
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.only(left: 20, top: 30, bottom: 30),
            borderRadius: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddressLine(
                          label: AppLocalizations.of(context)!.street,
                          content: address.street),
                      AddressLine(
                          label: AppLocalizations.of(context)!.city,
                          content: address.city),
                      AddressLine(
                          label: AppLocalizations.of(context)!.state,
                          content: address.state),
                      AddressLine(
                          label: AppLocalizations.of(context)!.phoneNumber,
                          content: address.phoneNumber),
                      AddressLine(
                          label: AppLocalizations.of(context)!.zipCode,
                          content: address.zipCode),
                      AddressLine(
                          label:
                              AppLocalizations.of(context)!.countryCallingCode,
                          content: address.countryCallingCode),
                      AddressLine(
                          label: AppLocalizations.of(context)!.country,
                          content: address.country),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () => _navigateToEditAddressScreen(context),
                    child: Text(AppLocalizations.of(context)!.edit)),
              ],
            )),
      ),
    );
  }

  void _navigateToEditAddressScreen(BuildContext context) {
    Navigator.pushNamed(context, AddAddressScreen.routeName,
        arguments: address);
  }

  void _onDeleteAddress(BuildContext context) {
    context.read<AddressesBloc>().add(DeleteAddress(addressId: address.id));
  }
}
