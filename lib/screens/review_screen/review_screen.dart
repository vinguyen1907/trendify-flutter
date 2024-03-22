import 'package:ecommerce_app/blocs/review_screen_bloc/review_screen_bloc.dart';
import 'package:ecommerce_app/common_widgets/cart_button.dart';
import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/screens/cart_screen/cart_screen.dart';
import 'package:ecommerce_app/screens/review_screen/widgets/list_reviews.dart';
import 'package:ecommerce_app/screens/review_screen/widgets/no_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.productId});

  static const String routeName = '/review-screen';
  final String productId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    context
        .read<ReviewScreenBloc>()
        .add(LoadReviews(productId: widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(
        actions: [
          CartButton(
            onTap: () => Navigator.pushNamed(context, CartScreen.routeName),
          )
        ],
      ),
      body: BlocBuilder<ReviewScreenBloc, ReviewScreenState>(
        builder: (context, state) {
          if (state is ReviewScreenLoading) {
            return const CustomLoadingWidget();
          } else if (state is ReviewScreenLoaded) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: ScreenNameSection(
                        label: 'Reviews Client',
                      ),
                    ),
                    state.reviews.isNotEmpty
                        ? ListReviews(
                            reviews: state.reviews,
                          )
                        : const NoReview()
                  ],
                ),
              ),
            );
          } else if (state is ReviewScreenError) {
            return Center(
              child: Text(
                state.message,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
