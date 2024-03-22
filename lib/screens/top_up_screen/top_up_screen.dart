import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/constants/default_top_up_amounts.dart';
import 'package:ecommerce_app/screens/e_wallet_cards_screen/e_wallet_cards_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  static const String routeName = "/top-up-screen";

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final TextEditingController _amountController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(children: [
        const SizedBox(height: 20),
        Text(AppLocalizations.of(context)!.enterTopUpAmount),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultPadding),
          child: Form(
            key: _key,
            child: TextFormField(
              controller: _amountController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
              validator: _validator,
              decoration: InputDecoration(
                enabledBorder: AppStyles.topUpEnabledBorder.copyWith(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 2),
                ),
                focusedBorder: AppStyles.topUpEnabledBorder.copyWith(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 2),
                ),
                errorBorder: AppStyles.topUpErrorBorder,
                focusedErrorBorder: AppStyles.topUpErrorBorder,
                hintText: "\$0.00",
                hintStyle: const TextStyle(
                  color: AppColors.darkGreyColor,
                ),
                errorStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.errorColor,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ),
        ),
        GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding, vertical: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10),
            itemCount: defaultTopUpAmounts.length,
            itemBuilder: (_, index) {
              return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          width: 2)),
                  onPressed: () {
                    _amountController.text =
                        defaultTopUpAmounts[index].toString();
                  },
                  child: Text(
                    "\$${defaultTopUpAmounts[index]}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ));
            }),
        const Spacer(),
        MyButton(
            margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding),
            onPressed: _navigateToCardsScreen,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.continueButton,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.whiteColor))
              ],
            )),
        const SizedBox(height: 20),
      ]),
    );
  }

  _navigateToCardsScreen() {
    if (_key.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        EWalletCardsScreen.routeName,
        arguments: double.parse(_amountController.text),
      );
    }
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Amount must be greater than 0";
    }
    if (double.tryParse(value) == null) {
      return "Amount is invalid";
    }
    return null;
  }
}
