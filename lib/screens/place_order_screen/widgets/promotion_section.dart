import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/section_label.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:ecommerce_app/screens/choose_promotion_screen/choose_promotion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromotionSection extends StatelessWidget {
  const PromotionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(label: "Promo Code"),
        InkWell(
          onTap: () => _navigateToChoosePromotion(context),
          child: PrimaryBackground(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const MyIcon(
                      icon: AppAssets.icPromotion,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                          AppColors.whiteColor, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Add Promo Code",
                          style: AppStyles.labelMedium),
                      BlocBuilder<PlaceOrderBloc, PlaceOrderState>(
                        builder: (context, state) {
                          if (state.promotion != null) {
                            return Text("#${state.promotion!.code}",
                                style: AppStyles.bodyMedium);
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ],
    );
  }

  _navigateToChoosePromotion(BuildContext context) {
    Navigator.pushNamed(context, ChoosePromotionScreen.routeName);
  }
}
