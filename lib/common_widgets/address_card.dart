import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/address_line.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    this.width,
    this.height,
  });

  final ShippingAddress address;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return PrimaryBackground(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        borderRadius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddressLine(label: "Street", content: address.street),
            AddressLine(label: "City", content: address.city),
            AddressLine(label: "State/province/area", content: address.state),
            AddressLine(label: "Phone number", content: address.phoneNumber),
            AddressLine(label: "Zip code", content: address.zipCode),
            AddressLine(
                label: "Country calling code",
                content: address.countryCallingCode),
            AddressLine(label: "Country", content: address.country),
          ],
        ));
  }
}
