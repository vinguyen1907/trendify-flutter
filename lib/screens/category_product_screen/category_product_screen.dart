import 'package:ecommerce_app/blocs/category_product_bloc/category_product_bloc.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widgets/common_widgets.dart';
import '../../models/models.dart';
import '../home_screen/widgets/widgets.dart';
import 'category_product_search.dart';

class CategoryProductScreen extends StatefulWidget {
  const CategoryProductScreen({super.key});

  static const String routeName = '/category-product-screen';

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  late final Category category;
 
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is Category) {
        category = args;
        context
        .read<CategoryProductBloc>()
        .add(LoadProductsInCategory(category: category));
      }
    }
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
                child: CustomLoadingWidget(),
              );
            } else if (state is CategoryProductLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenNameSection(
                      label: category.name,
                    ),
                    ProductsGridView(
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
