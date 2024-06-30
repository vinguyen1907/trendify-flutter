// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/blocs/show_notification/show_notification_bloc.dart';
import 'package:ecommerce_app/blocs/similar_products_bloc/similar_products_bloc.dart';
import 'package:ecommerce_app/blocs/similar_products_bloc/similar_products_event.dart';
import 'package:ecommerce_app/common_widgets/common_widgets.dart';
import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/widgets.dart';
import 'package:ecommerce_app/screens/screens.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key});

  static const String routeName = '/detail-product-screen';

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  late final Product product;

  @override
  void initState() {
    // context.read<CartBloc>().add(LoadCart());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (mounted) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is Product) {
        product = args;
        context.read<ProductBloc>().add(LoadProductDetails(product: product));
        context.read<SimilarProductsBloc>().add(LoadSimilarProducts(productCode: product.code));
      }
    }
    super.didChangeDependencies();
  }

  void _showNotification(BuildContext context) {
    Utils.showSnackBarSuccess(
        context: context,
        message: "The product has been added to cart.",
        title: "Success",
        actionButton: TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context.read<ProductBloc>().add(const UndoAddToCart());
            },
            child: Text(
              "Undo",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),
            )));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: MyAppBar(
        actions: [
          // TODO: Recover it
          CartButton(
            onTap: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
          )
        ],
      ),
      // body: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 25),
      //             child: SizedBox(
      //               height: double.infinity,
      //               child: Stack(
      //                 alignment: Alignment.bottomCenter,
      //                 children: [
      //                   SingleChildScrollView(
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         ProductImage(
      //                           product: product,
      //                         ),
      //                         ProductTile(
      //                           product: product,
      //                         ),
      //                         const ProductSize(),
      //                         ProductDescription(
      //                           description: product.description,
      //                         ),
      //                         const SizedBox(height: 30),
      //                         const Text(
      //                           "Similar Products",
      //                           style: AppStyles.headlineMedium,
      //                         ),
      //                         const SizedBox(height: 10),
      //                 SizedBox(
      //                   height: 200,
      //                   child: ListView.separated(
      //                     scrollDirection: Axis.horizontal,
      //                     shrinkWrap: true,
      //                     itemCount: state.productDetails.length,
      //                     separatorBuilder: (_, index) {
      //                       return const SizedBox(
      //                         width: 10,
      //                       );
      //                     },
      //                     itemBuilder: (_, index) {
      //                       return ProductItem(
      //                         product: product,
      //                         imageHeight: 120,
      //                         imageWidth: 120,
      //                       );
      //                     },
      //                   ),
      //                 ),
      //                         SizedBox(
      //                           height: size.height * 0.07 + 40,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   BottomBarProduct(
      //                     product: product,
      //                   )
      //                 ],
      //               ),
      //     )),
      body: BlocListener<ShowNotificationBloc, ShowNotificationState>(
        listener: (_, state) {
          if (state is AddToCartSuccess) {
            _showNotification(context);
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CustomLoadingWidget(),
              );
            } else if (state is ProductLoaded) {
              return SizedBox(
                height: double.infinity,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductImage(
                            product: product,
                          ),
                          ProductTile(
                            product: product,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 25),
                          //   child: Text(
                          //     product.price.toPriceString(),
                          //     style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: const Color(0xFF2B75F8)),
                          //   ),
                          // ),
                          const ProductSize(),
                          ProductDescription(
                            description: product.description,
                          ),
                          ProductCharacteristicsWidget(product: product),
                          const SizedBox(height: 30),
                          const SimilarProductsList(),
                          SizedBox(
                            height: size.height * 0.07 + 40,
                          ),
                        ],
                      ),
                    ),
                    BottomBarProduct(
                      product: product,
                    )
                  ],
                ),
              );
            } else if (state is ProductError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
