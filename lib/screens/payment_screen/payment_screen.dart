import 'package:ecommerce_app/blocs/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/extensions/payment_method_extension.dart';
import 'package:ecommerce_app/models/payment_information.dart';
import 'package:ecommerce_app/models/payment_method_resource.dart';
import 'package:ecommerce_app/repositories/payment_methods_repository.dart';
import 'package:ecommerce_app/screens/e_wallet_screen/e_wallet_screen.dart';
import 'package:ecommerce_app/screens/payment_screen/widgets/confirm_payment_button.dart';
import 'package:ecommerce_app/screens/payment_screen/widgets/payment_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  static const String routeName = "/payment-screen";

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodsBloc>().add(LoadPaymentMethods());
    context
        .read<PlaceOrderBloc>()
        .add(const UpdatePaymentInformation(paymentMethod: null)); //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ScreenNameSection(label: "Payment"),
          BlocBuilder<PaymentMethodsBloc, PaymentMethodsState>(
            builder: (context, state) {
              if (state is PaymentMethodsLoading) {
                return const Center(child: CustomLoadingWidget());
              } else if (state is PaymentMethodsError) {
                return const Text("Something went wrong");
              } else if (state is PaymentMethodsLoaded) {
                final List<PaymentInformation> paymentCards = state.paymentCards;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding),
                    itemCount: PaymentMethods.values.length,
                    itemBuilder: (_, index) {
                      final paymentMethod = PaymentMethods.values[index];
                  
                      PaymentInformation? thisPaymentInformation;
                      final tempLst = paymentCards.where((element) => element.type == paymentMethod.code);
                      thisPaymentInformation = tempLst.isNotEmpty ? tempLst.first : null;
                  
                      switch (paymentMethod) {
                        // case PaymentMethods.eWallet:
                        //   return BlocBuilder<UserBloc, UserState>(
                        //     builder: (context, state) {
                        //       String? subTitle;
                        //       double? balance;
                        //       if (state is UserLoaded) {
                        //         subTitle = "Balance: ${state.user.eWalletBalance.toPriceString()}";
                        //         balance = state.user.eWalletBalance;
                        //       }
                        //       return BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
                        //         builder: (context, state) {
                        //           final isEnabled = balance != null && balance >= state.totalPrice!;
                        //           return PaymentItemCard(
                        //             isEnabled: isEnabled,
                        //             isSelected: state.paymentMethod?.code == paymentMethod.code,
                        //             subTitle: subTitle,
                        //             paymentMethod: paymentMethodsResource[paymentMethod]!,
                        //             paymentCard: thisPaymentInformation,
                        //             onTap: isEnabled ? () => _onSelectPayment(paymentMethod: paymentMethodsResource[paymentMethod]!) : null,
                        //             action: TextButton(onPressed: _navigateToTopUpScreen, child: const Text("Top Up")),
                        //           );
                        //         },
                        //       );
                        //     },
                        //   );
                        case PaymentMethods.mastercard:
                        // case PaymentMethods.paypal:
                        case PaymentMethods.visa:
                        // case PaymentMethods.googlePay:
                        //   return BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
                        //     builder: (context, state) {
                        //       return PaymentItemCard(
                        //         isSelected: state.paymentMethod?.code == paymentMethod.code,
                        //         paymentMethod: paymentMethodsResource[paymentMethod]!,
                        //         paymentCard: thisPaymentInformation,
                        //         onTap: thisPaymentInformation == null
                        //             ? null
                        //             : () => _onSelectPayment(
                        //                 paymentMethod: paymentMethodsResource[paymentMethod]!, paymentInformation: thisPaymentInformation),
                        //       );
                        //     },
                        //   );
                        // case PaymentMethods.zaloPay:
                        //   return BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
                        //     builder: (context, state) {
                        //       return PaymentItemCard(
                        //         isSelected: state.paymentMethod?.code == paymentMethod.code,
                        //         paymentMethod: paymentMethodsResource[paymentMethod]!,
                        //         paymentCard: PaymentInformation(id: "zalo_pay", type: "zalo_pay"),
                        //         onTap: () => _onSelectPayment(
                        //             paymentMethod: paymentMethodsResource[paymentMethod]!, paymentInformation: thisPaymentInformation),
                        //       );
                        //     },
                        //   );
                        case PaymentMethods.cashOnDelivery:
                          return BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
                            builder: (context, state) {
                              return PaymentItemCard(
                                isSelected: state.paymentMethod?.code == paymentMethod.code,
                                paymentMethod: paymentMethodsResource[paymentMethod]!,
                                paymentCard: thisPaymentInformation,
                                onTap: () => _onSelectPayment(
                                  paymentMethod: paymentMethodsResource[paymentMethod]!,
                                ),
                              );
                            },
                          );
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const ConfirmPaymentButton(),
        ],
      ),
    );
  }

  void _onSelectPayment(
      {required PaymentMethodResource paymentMethod,
      PaymentInformation? paymentInformation}) {
    if (paymentInformation != null) {
      _onUpdatePaymentInformation(
          paymentMethod: paymentMethod, paymentInformation: paymentInformation);
    } else {
      _onUpdatePaymentInformation(paymentMethod: paymentMethod);
    }
  }

  void _onUpdatePaymentInformation(
      {required PaymentMethodResource paymentMethod,
      PaymentInformation? paymentInformation}) {
    context.read<PlaceOrderBloc>().add(UpdatePaymentInformation(
        paymentInformation: paymentInformation, paymentMethod: paymentMethod));
  }

  void _navigateToTopUpScreen() {
    Navigator.pushNamed(context, EWalletScreen.routeName);
  }
}
