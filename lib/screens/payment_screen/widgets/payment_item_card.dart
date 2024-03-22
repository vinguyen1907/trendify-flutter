import 'dart:ui';

import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/payment_method_extension.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:ecommerce_app/models/payment_information.dart';
import 'package:ecommerce_app/models/payment_method_resource.dart';
import 'package:ecommerce_app/repositories/payment_methods_repository.dart';
import 'package:ecommerce_app/screens/add_payment_card_screen/add_payment_card_screen.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:flutter/material.dart';

class PaymentItemCard extends StatelessWidget {
  final bool isSelected;
  final PaymentMethodResource paymentMethod;
  final PaymentInformation? paymentCard;
  final VoidCallback? onTap;
  final String? subTitle;
  final bool isEnabled;
  final Widget? action;

  const PaymentItemCard({
    super.key,
    required this.isSelected,
    required this.paymentMethod,
    required this.paymentCard,
    required this.onTap,
    this.subTitle,
    this.isEnabled = true,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isEnabled ? 1 : 0.5,
        child: PrimaryBackground(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            backgroundColor: isSelected
                ? Theme.of(context).colorScheme.tertiaryContainer
                : Theme.of(context).colorScheme.secondaryContainer,
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(paymentMethod.imageAsset)),
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentMethod.name,
                      style: AppStyles.labelMedium.copyWith(
                          color: isSelected
                              ? Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer
                              : Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                    ),
                    if (paymentCard != null && paymentCard!.cardNumber != null)
                      Text(
                        paymentCard!.cardNumber?.maskCardNumber() ?? "",
                        style: AppStyles.bodyLarge.copyWith(
                            color: isSelected
                                ? Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer
                                : Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                      ),
                    if (subTitle != null)
                      Text(
                        subTitle!,
                        style: AppStyles.bodyLarge.copyWith(
                            color: isSelected
                                ? Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer
                                : Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                      ),
                  ],
                ),
                const Spacer(),
                if (paymentCard == null &&
                    paymentMethod.code != PaymentMethods.eWallet.code &&
                    paymentMethod.code != PaymentMethods.cashOnDelivery.code)
                  TextButton(
                      onPressed: () => _navigateToAddPaymentCardScreen(context),
                      child: Text(
                        "Add",
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                if (action != null) action!,
              ],
            )),
      ),
    );
  }

  _navigateToAddPaymentCardScreen(BuildContext context) {
    Navigator.pushNamed(context, AddPaymentCardScreen.routeName);
  }
}
