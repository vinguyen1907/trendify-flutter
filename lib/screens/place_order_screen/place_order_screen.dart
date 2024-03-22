import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/common_widgets/section_label.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/address_section.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/place_order_bill.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/place_order_product_items.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/promotion_section.dart';
import 'package:ecommerce_app/screens/place_order_screen/widgets/place_order_summary.dart';
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
                  PromotionSection(),
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
