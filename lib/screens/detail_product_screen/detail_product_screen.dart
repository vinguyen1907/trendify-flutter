import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/blocs/show_notification/show_notification_bloc.dart';
import 'package:ecommerce_app/common_widgets/cart_button.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/bottom_bar_product.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/product_description.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/product_image.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/product_size.dart';
import 'package:ecommerce_app/screens/detail_product_screen/widgets/product_title.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({super.key, required this.product});

  final Product product;
  static const String routeName = '/detail-product-screen';

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  void initState() {
    context
        .read<ProductBloc>()
        .add(LoadProductDetails(product: widget.product));
    context.read<CartBloc>().add(LoadCart());
    super.initState();
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
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white),
            )));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        actions: [
          CartButton(
            onTap: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
          )
        ],
      ),
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
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductLoaded) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    height: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ProductImage(
                                product: widget.product,
                              ),
                              ProductTile(
                                product: widget.product,
                              ),
                              ProductDescription(
                                description: widget.product.description,
                              ),
                              const ProductSize(),
                              SizedBox(
                                height: size.height * 0.07 + 40,
                              )
                            ],
                          ),
                        ),
                        BottomBarProduct(
                          product: widget.product,
                        )
                      ],
                    ),
                  ));
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
