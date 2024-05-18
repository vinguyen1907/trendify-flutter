import 'package:ecommerce_app/blocs/search_filter_bloc/search_filter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_widgets/common_widgets.dart';
import '../../constants/constants.dart';
import '../home_screen/widgets/widgets.dart';
import '../screens.dart';
import 'widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const String routeName = '/search-screen';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final String? query;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is String) {
        query = args;
        if (query != null) {
          context.read<SearchFilterBloc>().add(LoadResultProducts(query: query!));
        }
      }
    }
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
                              label: "\"$query\"",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: AppDimensions.defaultPadding),
                              child: InkWell(
                                onTap: () {
                                  state.resultProducts.length > 1 ? Navigator.pushNamed(context, FilterScreen.routeName) : null;
                                },
                                child: const Icon(Icons.tune),
                              ),
                            )
                          ],
                        ),
                        ProductsGridView(
                          products: state.resultProducts,
                          productCount: state.resultProducts.length,
                        )
                      ],
                    ))
                  : NotFound(title: "\"$query\"");
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
