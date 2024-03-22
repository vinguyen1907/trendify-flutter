import 'package:ecommerce_app/blocs/category_bloc/category_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/screens/category_screen/widgets/grid_view_category.dart';
import 'package:ecommerce_app/screens/category_screen/widgets/search_category_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  static const String routeName = '/category-screen';

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(const LoadCategory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CategoryLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SearchCategoryBar(),
                    GridViewCategory(
                      categories: state.categories,
                    )
                  ],
                ),
              );
            } else if (state is CategoryError) {
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
