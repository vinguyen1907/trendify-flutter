import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

class ScreenNameSection extends StatelessWidget {
  final String label;
  final EdgeInsets margin;
  const ScreenNameSection({
    super.key,
    this.margin = const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultPadding, vertical: 15),
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        label,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
