import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PlaneLoadingWidget extends StatelessWidget {
  const PlaneLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: LottieBuilder.asset(
        AppAssets.lottiePlaneLoading,
        width: size.width * 0.5,
      ),
    );
  }
}
