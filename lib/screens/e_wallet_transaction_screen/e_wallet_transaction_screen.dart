import 'package:ecommerce_app/common_widgets/common_widgets.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/extensions/extensions.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/router/arguments/arguments.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({super.key});

  static const String routeName = '/e-wallet-transaction-screen';

  @override
  State<TransactionDetailsScreen> createState() => _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  late final EWalletTransaction transaction;
  final PageController _pageController = PageController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is EWalletTransactionScreenArgs) {
        transaction = args.transaction;
      }
    }
  }

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
          if (transaction is PaymentTransaction)
            PrimaryBackground(
                margin: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      child: PageView.builder(
                          controller: _pageController,
                          itemCount: (transaction as PaymentTransaction).items.length,
                          itemBuilder: (_, index) {
                            final CartItem item = (transaction as PaymentTransaction).items[index];
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
                                            .copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer)),
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
                        count: (transaction as PaymentTransaction).items.length,
                        effect: const WormEffect(
                          dotWidth: 8,
                          dotHeight: 8,
                        ), // your preferred effect
                        onDotClicked: (index) {})
                  ],
                )),
          const SizedBox(height: 20),
          if (transaction is PaymentTransaction)
            PrimaryBackground(
                margin: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
                padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                child: Column(
                  children: [
                    TransactionItem(label: "Amount", number: (transaction as PaymentTransaction).amount.toPriceString()),
                    TransactionItem(label: "Promotion", number: (transaction as PaymentTransaction).promotionAmount.toPriceString()),
                    TransactionItem(label: "Shipping fee", number: (transaction as PaymentTransaction).shippingFee.toPriceString()),
                    const Divider(),
                    TransactionItem(label: "Total", number: (transaction as PaymentTransaction).totalAmount.toPriceString()),
                  ],
                )),
          const SizedBox(height: 20),
          PrimaryBackground(
              margin: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
              padding: const EdgeInsets.all(AppDimensions.defaultPadding),
              child: Column(
                children: [
                  if (transaction is PaymentTransaction) const TransactionItem(label: "Payment Method", number: "My E-Wallet"),
                  TransactionItem(label: "Date", number: transaction.createdTime.toTransactionDateTimeFormat()),
                  TransactionItem(label: "Transaction ID", number: transaction.id),
                  TransactionItem(label: "Category", number: transaction is PaymentTransaction ? "Orders" : "Top Up"),
                  if (transaction is TopUpTransaction)
                    TransactionItem(label: "Amount", number: (transaction as TopUpTransaction).amount.toPriceString()),
                ],
              )),
        ],
      ),
    );
  }
}
