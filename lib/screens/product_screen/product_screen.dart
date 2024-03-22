import 'package:ecommerce_app/blocs/product_screen_bloc/product_screen_bloc.dart';
import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/grid_view_product.dart';
import 'package:ecommerce_app/screens/product_screen/product_screen_search.dart';
import 'package:ecommerce_app/screens/search_screen/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
    required this.sectionName,
    required this.products,
  });

  static const String routeName = '/product-screen';
  final String sectionName;
  final List<Product> products;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    context.read<ProductScreenBloc>().add(LoadProducts(
        products: widget.products, sectionName: widget.sectionName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(actions: [
          GestureDetector(
              onTap: () => showSearch(
                  context: context, delegate: ProductScreenSearchDelegate()),
              child: const MyIcon(icon: AppAssets.icSearch))
        ]),
        body: BlocBuilder<ProductScreenBloc, ProductScreenState>(
          builder: (context, state) {
            if (state is ProductScreenLoading) {
              return const CustomLoadingWidget();
            } else if (state is ProductScreenLoaded) {
              return state.products.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ScreenNameSection(
                            label: state.sectionName,
                          ),
                          GridViewProduct(
                            products: state.products,
                            productCount: state.products.length,
                          )
                        ],
                      ),
                    )
                  : NotFound(title: state.sectionName);
            } else if (state is ProductScreenError) {
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
