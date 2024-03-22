import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:ecommerce_app/repositories/promotion_repository.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/promotion_item.dart';
import 'package:flutter/material.dart';

class PromotionScreen extends StatelessWidget {
  const PromotionScreen({super.key, required this.promotions});

  static const String routeName = "/promotion-screen";
  final List<Promotion> promotions;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ScreenNameSection(label: "Promotion"),
            promotions.isEmpty
                ? const Align(
                    alignment: Alignment.center,
                    child: Text("You don't have any promotion yet.",
                        style: AppStyles.bodyLarge),
                  )
                : Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.defaultPadding),
                        shrinkWrap: true,
                        itemCount: promotions.length,
                        separatorBuilder: (_, index) {
                          return const SizedBox(height: 10);
                        },
                        itemBuilder: (_, index) {
                          return PromotionItem(
                            promotion: promotions[index],
                            width:
                                size.width - 2 * AppDimensions.defaultPadding,
                            height: size.height * 0.2,
                            onGetPromotion: () =>
                                _onGetPromotion(promotions[index]),
                          );
                        }),
                  )
          ]),
    );
  }

  _onGetPromotion(Promotion promotion) async {
    await PromotionRepository().addToMyPromotions(promotion: promotion);
  }
}
