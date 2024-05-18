import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoReview extends StatelessWidget {
  const NoReview({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.12,
        ),
        SvgPicture.asset(
          AppAssets.imgNoReview,
          height: size.height * 0.25,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "No review yet.",
            style: AppStyles.headlineMedium,
          ),
        )
      ],
    );
  }
}
