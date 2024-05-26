import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/common_widgets/cart_button.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_list.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/summary_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static const String routeName = '/cart-screen';
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(InitConnection(updateCart: (Cart cart) {
      if (mounted) {
        context.read<CartBloc>().add(UpdateCart(cart: cart));
      }
    }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        hideDefaultLeadingButton: true,
        actions: [CartButton()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenNameSection(
            label: "My Cart",
          ),
          CartList(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
          ),
          SummarySection(
            margin: EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding, vertical: 15),
          ),
        ],
      ),
    );
  }
}
