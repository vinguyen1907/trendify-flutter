import 'package:ecommerce_app/blocs/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/extensions/payment_method_extension.dart';
import 'package:ecommerce_app/models/payment_information.dart';
import 'package:ecommerce_app/repositories/payment_methods_repository.dart';
import 'package:ecommerce_app/screens/payment_screen/widgets/payment_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyCardsScreen extends StatefulWidget {
  const MyCardsScreen({super.key});

  static const String routeName = "/my-card-screen";

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentMethodsBloc>().add(LoadPaymentMethods());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenNameSection(label: AppLocalizations.of(context)!.myCards),
            BlocBuilder<PaymentMethodsBloc, PaymentMethodsState>(
              builder: (context, state) {
                if (state is PaymentMethodsLoading) {
                  return const Center(child: CustomLoadingWidget());
                } else if (state is PaymentMethodsError) {
                  return const Text("Something went wrong");
                } else if (state is PaymentMethodsLoaded) {
                  final List<PaymentInformation> paymentCards =
                      state.paymentCards;
                  return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.defaultPadding),
                      shrinkWrap: true,
                      itemCount: PaymentMethods.values.length -
                          1, // no need to show cash on delivery method
                      itemBuilder: (_, index) {
                        PaymentInformation? thisPaymentInformation;
                        final thisPaymentMethod = PaymentMethods.values[index];
                        final tempLst = paymentCards.where((element) =>
                            element.type == thisPaymentMethod.code);
                        thisPaymentInformation =
                            tempLst.isNotEmpty ? tempLst.first : null;

                        if (thisPaymentMethod == PaymentMethods.zaloPay) {
                          return const SizedBox();
                        }

                        return BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
                          builder: (context, state) {
                            return PaymentItemCard(
                                isSelected: false,
                                paymentMethod:
                                    paymentMethodsResource[thisPaymentMethod]!,
                                paymentCard: thisPaymentInformation,
                                onTap: () {});
                          },
                        );
                      });
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
