import 'package:ecommerce_app/blocs/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/router/arguments/arguments.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/products_grid_view.dart';
import 'package:ecommerce_app/screens/all_products_screen/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final currentState = state as HomeLoaded;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.defaultPadding, vertical: 8),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Text(
                    "Recommend for you",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  GestureDetector(
                    onTap: () => _navigateToProductScreen(context, state.newArrivals),
                    child: Text(
                      "View All",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  )
                ]),
              ),
              ProductsGridView(
                products: currentState.newArrivals,
                productCount: 10,
              )
            ],
          ),
        );
      },
    );
  }

  void _navigateToProductScreen(BuildContext context, List<Product> products) {
    Navigator.pushNamed(
      context,
      AllProductsScreen.routeName,
      arguments: AllProductsScreenArgs(products: products, sectionName: "Recommend for you"),
    );
  }
}
