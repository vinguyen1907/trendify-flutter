import 'package:ecommerce_app/common_widgets/color_dot_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/common_widgets/transaction_item.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/extensions/date_time_extension.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/e_wallet_transaction.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({
    super.key,
    required this.transaction,
  });

  final EWalletTransaction transaction;

  static const String routeName = '/e-wallet-transaction-screen';

  @override
  State<TransactionDetailsScreen> createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenNameSection(label: "E-Receipt"),
          if (widget.transaction is PaymentTransaction)
            PrimaryBackground(
                margin: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultPadding),
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      child: PageView.builder(
                          controller: _pageController,
                          itemCount: (widget.transaction as PaymentTransaction)
                              .items
                              .length,
                          itemBuilder: (_, index) {
                            final CartItem item =
                                (widget.transaction as PaymentTransaction)
                                    .items[index];
                            return Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: AppColors.darkGreyColor,
                                    borderRadius: AppDimensions.circleCorners,
                                    image: DecorationImage(
                                      image: NetworkImage(item.product.imgUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(item.product.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer)),
                                    Row(
                                      children: [
                                        Text("Quantity: ${item.quantity}"),
                                        const SizedBox(width: 10),
                                        Text("Size: ${item.size}"),
                                        const SizedBox(width: 10),
                                        const Text("Color: "),
                                        ColorDotWidget(color: item.color)
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            );
                          }),
                    ),
                    SmoothPageIndicator(
                        controller: _pageController, // PageController
                        count: (widget.transaction as PaymentTransaction)
                            .items
                            .length,
                        effect: const WormEffect(
                          dotWidth: 8,
                          dotHeight: 8,
                        ), // your preferred effect
                        onDotClicked: (index) {})
                  ],
                )),
          const SizedBox(height: 20),
          if (widget.transaction is PaymentTransaction)
            PrimaryBackground(
                margin: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultPadding),
                padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                child: Column(
                  children: [
                    TransactionItem(
                        label: "Amount",
                        number: (widget.transaction as PaymentTransaction)
                            .amount
                            .toPriceString()),
                    TransactionItem(
                        label: "Promotion",
                        number: (widget.transaction as PaymentTransaction)
                            .promotionAmount
                            .toPriceString()),
                    TransactionItem(
                        label: "Shipping fee",
                        number: (widget.transaction as PaymentTransaction)
                            .shippingFee
                            .toPriceString()),
                    const Divider(),
                    TransactionItem(
                        label: "Total",
                        number: (widget.transaction as PaymentTransaction)
                            .totalAmount
                            .toPriceString()),
                  ],
                )),
          const SizedBox(height: 20),
          PrimaryBackground(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding),
              padding: const EdgeInsets.all(AppDimensions.defaultPadding),
              child: Column(
                children: [
                  if (widget.transaction is PaymentTransaction)
                    const TransactionItem(
                        label: "Payment Method", number: "My E-Wallet"),
                  TransactionItem(
                      label: "Date",
                      number: widget.transaction.createdTime
                          .toTransactionDateTimeFormat()),
                  TransactionItem(
                      label: "Transaction ID", number: widget.transaction.id),
                  TransactionItem(
                      label: "Category",
                      number: widget.transaction is PaymentTransaction
                          ? "Orders"
                          : "Top Up"),
                  if (widget.transaction is TopUpTransaction)
                    TransactionItem(
                        label: "Amount",
                        number: (widget.transaction as TopUpTransaction)
                            .amount
                            .toPriceString()),
                ],
              )),
        ],
      ),
    );
  }
}
