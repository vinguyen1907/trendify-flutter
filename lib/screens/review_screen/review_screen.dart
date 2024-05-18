import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/common_widgets/common_widgets.dart';
import 'package:ecommerce_app/screens/review_screen/widgets/widgets.dart';
import 'package:ecommerce_app/screens/screens.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  static const String routeName = '/review-screen';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late final String productId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is String) {
        productId = args;
        context
        .read<ReviewScreenBloc>()
        .add(LoadReviews(productId: productId));
      }
    }
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
