import 'package:ecommerce_app/common_widgets/common_widgets.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key});

  static const String routeName = "/place-order-screen";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenNameSection(label: "Delivery Address"),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressSection(),
                  SectionLabel(label: "Product Items"),
                  PlaceOrderProductItems(),
                  // PromotionSection(),
                  SizedBox(height: 20),
                  PlaceOrderBill()
                ],
              ),
            ),
          ),
          PlaceOrderSummary()
        ],
      ),
    );
  }
}
