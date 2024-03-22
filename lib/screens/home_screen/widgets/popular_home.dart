import 'package:ecommerce_app/blocs/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/popular_product_item.dart';
import 'package:ecommerce_app/screens/product_screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularHome extends StatelessWidget {
  const PopularHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final currentState = state as HomeLoaded;
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Popular",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      GestureDetector(
                        onTap: () =>
                            _navigateToProductScreen(context, state.popular),
                        child: Text(
                          "View All",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
              ),
              ListView.builder(
                itemCount: currentState.popular.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return PopularProductItem(
                    product: currentState.popular[index],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToProductScreen(BuildContext context, List<Product> products) {
    Navigator.pushNamed(context, ProductScreen.routeName,
        arguments: {'sectionName': "Popular", 'products': products});
  }
}
