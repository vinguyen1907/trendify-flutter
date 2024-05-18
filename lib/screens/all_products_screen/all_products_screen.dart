import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../common_widgets/common_widgets.dart';
import '../../constants/constants.dart';
import '../../models/models.dart';
import '../../router/arguments/arguments.dart';
import '../home_screen/widgets/widgets.dart';
import '../search_screen/widgets/widgets.dart';
import 'widgets/widgets.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  static const String routeName = '/all-products-screen';

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  late final List<Product> products;
  late final String sectionName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is AllProductsScreenArgs) {
        products = args.products;
        sectionName = args.sectionName;
        context.read<ProductScreenBloc>().add(LoadProducts(products: products, sectionName: sectionName));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actions: [
          GestureDetector(
            onTap: () => showSearch(context: context, delegate: ProductScreenSearchDelegate()),
            child: const MyIcon(icon: AppAssets.icSearch),
          )
        ],
      ),
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
                        ProductsGridView(
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
      ),
    );
  }
}
