import 'package:ecommerce_app/blocs/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/repositories/promotion_repository.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/promotion_item.dart';
import 'package:ecommerce_app/screens/promotion_screen/promotion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromotionsHome extends StatelessWidget {
  const PromotionsHome({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final currentState = state as HomeLoaded;
        final promotions = currentState.promotions;
        return promotions.isEmpty
            ? const Text("No promotions in this time")
            : SingleChildScrollView(
                padding: const EdgeInsets.only(left: AppDimensions.defaultPadding),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    currentState.promotions.length + 1,
                    (index) => index < currentState.promotions.length
                        ? PromotionItem(
                            height: size.height * 0.2,
                            width: size.width * 0.7,
                            margin: const EdgeInsets.only(right: 20),
                            promotion: currentState.promotions[index],
                            onGetPromotion: () {
                              PromotionRepository().addToMyPromotions(promotion: currentState.promotions[index]);
                            },
                          )
                        : IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, PromotionScreen.routeName, arguments: currentState.promotions);
                            },
                            icon: const Icon(Icons.chevron_right),
                            color: Colors.black,
                          ),
                  ),
                ),
              );
      },
    );
  }
}
