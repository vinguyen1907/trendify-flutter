import 'package:ecommerce_app/blocs/search_filter_bloc/search_filter_bloc.dart';
import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/filter_screen/filter_screen.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/grid_view_product.dart';
import 'package:ecommerce_app/screens/search_screen/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.query});
  static const String routeName = '/search-screen';
  final String query;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    context
        .read<SearchFilterBloc>()
        .add(LoadResultProducts(query: widget.query));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: BlocBuilder<SearchFilterBloc, SearchFilterState>(
          builder: (context, state) {
            if (state is SearchFilterLoading) {
              return const CustomLoadingWidget();
            } else if (state is SearchFilterLoaded) {
              return state.resultProducts.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ScreenNameSection(
                              label: "\"${widget.query}\"",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: AppDimensions.defaultPadding),
                              child: InkWell(
                                onTap: () {
                                  state.resultProducts.length > 1
                                      ? Navigator.pushNamed(
                                          context, FilterScreen.routeName)
                                      : null;
                                },
                                child: const Icon(Icons.tune),
                              ),
                            )
                          ],
                        ),
                        GridViewProduct(
                          products: state.resultProducts,
                          productCount: state.resultProducts.length,
                        )
                      ],
                    ))
                  : NotFound(title: "\"${widget.query}\"");
            } else if (state is SearchFilterError) {
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
