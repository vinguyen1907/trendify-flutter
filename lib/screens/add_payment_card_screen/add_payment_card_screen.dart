import 'package:credit_card_scanner/credit_card_scanner.dart';
import 'package:ecommerce_app/blocs/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:ecommerce_app/common_widgets/loading_manager.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/repositories/payment_repository.dart';
import 'package:ecommerce_app/screens/add_payment_card_screen/widgets/scan_button.dart';
import 'package:ecommerce_app/screens/set_passcode_screen/set_passcode_screen.dart';
import 'package:ecommerce_app/utils/passcode_utils.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddPaymentCardScreen extends StatefulWidget {
  const AddPaymentCardScreen({super.key});

  static const String routeName = "add-payment-card-screen";

  @override
  State<AddPaymentCardScreen> createState() => _AddPaymentCardScreenState();
}

class _AddPaymentCardScreenState extends State<AddPaymentCardScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = "";
  String expiryDate = "";
  String cardHolderName = "";
  String cvvCode = "";
  bool isCvvFocused = false;
  String cardType = CardType.otherBrand.name;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingManager(
      isLoading: isLoading,
      child: Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const ScreenNameSection(label: "Add Payment Card"),
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              isHolderNameVisible: true,
              cvvCode: cvvCode,
              showBackView:
                  isCvvFocused, //true when you want to show cvv(back) view
              onCreditCardWidgetChange: (cardBrand) {
                if (cardBrand.brandName != null) {
                  cardType = cardBrand.brandName!.name;
                }
              },
              cardBgColor: AppColors.primaryColor,
            ),
            CreditCardForm(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              formKey: formKey,
              onCreditCardModelChange: (creditCardModel) {
                print("Changed");
                print(creditCardModel.cardHolderName);
                setState(() {
                  cardNumber = creditCardModel.cardNumber;
                  expiryDate = creditCardModel.expiryDate;
                  cardHolderName = creditCardModel.cardHolderName;
                  cvvCode = creditCardModel.cvvCode;
                  isCvvFocused = creditCardModel.isCvvFocused;
                });
              },
              themeColor: AppColors.primaryColor,
              obscureCvv: true,
              obscureNumber: true,
              cardNumberDecoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Number',
                hintText: '**** **** **** ****',
                enabledBorder: AppStyles.paymentEnabledBorder,
                focusedBorder: AppStyles.paymentFocusedBorder,
                errorBorder: AppStyles.paymentErrorBorder,
                focusedErrorBorder: AppStyles.paymentFocusedErrorBorder,
              ),
              expiryDateDecoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Expired Date',
                hintText: '**/**',
                enabledBorder: AppStyles.paymentEnabledBorder,
                focusedBorder: AppStyles.paymentFocusedBorder,
                errorBorder: AppStyles.paymentErrorBorder,
                focusedErrorBorder: AppStyles.paymentFocusedErrorBorder,
              ),
              cvvCodeDecoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'CVV',
                hintText: '***',
                enabledBorder: AppStyles.paymentEnabledBorder,
                focusedBorder: AppStyles.paymentFocusedBorder,
                errorBorder: AppStyles.paymentErrorBorder,
                focusedErrorBorder: AppStyles.paymentFocusedErrorBorder,
              ),
              cardHolderDecoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Card Holder Name',
                enabledBorder: AppStyles.paymentEnabledBorder,
                focusedBorder: AppStyles.paymentFocusedBorder,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScanButton(onPressed: _onScanCard),
                MyButton(
                    onPressed: _onAddCard,
                    borderRadius: 12,
                    child: Text(
                      "Add card",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.whiteColor),
                    )),
              ],
            )
          ]),
        ),
      ),
    );
  }

  _onAddCard() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await PaymentRepository().addPaymentCard(
          cardNumber: cardNumber,
          holderName: cardHolderName,
          expiryDate: expiryDate,
          cvvCode: cvvCode,
          cardType: cardType,
        );
        if (!mounted) return;
        context.read<PaymentMethodsBloc>().add(LoadPaymentMethods());
        Utils.showSnackBarSuccess(
            context: context,
            message: "Your card is already add to your wallet.",
            title: "Add card successfully");
        Navigator.pop(context);

        final bool hasPasscode = await PasscodeUtils().hasPasscode();
        if (!hasPasscode) {
          if (!mounted) return;
          Navigator.pushNamed(context, SetPasscodeScreen.routeName);
        }
      } catch (e) {
        Utils.showSnackBar(
            context: context, message: "Failed to add card. Try again.");
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  _onScanCard() async {
    try {
      var cardDetails = await CardScanner.scanCard(
        scanOptions: const CardScanOptions(),
      );
      print("Scanned card");
      print(cardDetails == null);

      if (cardDetails != null) {
        setState(() {
          cardNumber = cardDetails.cardNumber;
          expiryDate = cardDetails.expiryDate;
          cardHolderName = cardDetails.cardHolderName;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
