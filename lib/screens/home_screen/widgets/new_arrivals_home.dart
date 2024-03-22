import 'package:ecommerce_app/blocs/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/grid_view_product.dart';
import 'package:ecommerce_app/screens/product_screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewArrivalsHome extends StatelessWidget {
  const NewArrivalsHome({super.key});

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
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultPadding, vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "New Arrivals",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      GestureDetector(
                        onTap: () => _navigateToProductScreen(
                            context, state.newArrivals),
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
              GridViewProduct(
                products: currentState.newArrivals,
                productCount: 2,
              )
            ],
          ),
        );
      },
    );
  }

  void _navigateToProductScreen(BuildContext context, List<Product> products) {
    Navigator.pushNamed(context, ProductScreen.routeName,
        arguments: {'sectionName': "New Arrivals", 'products': products});
  }
}
