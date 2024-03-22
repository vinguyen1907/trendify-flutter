import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String label;
  final EdgeInsets margin;
  const SectionLabel({
    super.key,
    required this.label,
    this.margin = const EdgeInsets.symmetric(
        horizontal: AppDimensions.defaultPadding, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Text(label, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}
