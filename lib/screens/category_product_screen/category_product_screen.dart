import 'package:ecommerce_app/blocs/category_product_bloc/category_product_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/screens/category_product_screen/category_product_search.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/grid_view_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key, required this.category});

  static const String routeName = '/category-product-screen';
  final Category category;

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  @override
  void initState() {
    context
        .read<CategoryProductBloc>()
        .add(LoadProductsInCategory(category: widget.category));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(actions: [
          GestureDetector(
              onTap: () => showSearch(
                  context: context, delegate: CategoryProductSearch()),
              child: const MyIcon(icon: AppAssets.icSearch))
        ]),
        body: BlocBuilder<CategoryProductBloc, CategoryProductState>(
          builder: (context, state) {
            if (state is CategoryProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryProductLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenNameSection(
                      label: widget.category.name,
                    ),
                    GridViewProduct(
                      products: state.products,
                      productCount: state.products.length,
                    )
                  ],
                ),
              );
            } else if (state is CategoryProductError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
