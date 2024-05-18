
import 'package:flutter/material.dart';

import 'package:ecommerce_app/common_widgets/common_widgets.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/repositories/promotion_repository.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/widgets.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({super.key});

  static const String routeName = "/promotion-screen";

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  late final List<Promotion> promotions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is List<Promotion>) {
        promotions = args;
      }
    }
  }

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
