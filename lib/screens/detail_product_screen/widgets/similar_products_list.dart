import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/blocs/similar_products_bloc/similar_products_state.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimilarProductsList extends StatelessWidget {
  const SimilarProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            "Similar Products",
            style: AppStyles.headlineMedium,
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<SimilarProductsBloc, SimilarProductsState>(
          builder: (context, state) {
            if (state is SimilarProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SimilarProductsError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is SimilarProductsLoaded) {
              final similarProducts = state.similarProducts;
              if (similarProducts.isEmpty) {
                return const Text("No similar products");
              }
              return SizedBox(
                height: 200,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: state.similarProducts.length,
                  separatorBuilder: (_, index) {
                    return const SizedBox(width: 10);
                  },
                  itemBuilder: (_, index) {
                    final product = state.similarProducts[index];
                    return SimilarProductCard(product: product);
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
