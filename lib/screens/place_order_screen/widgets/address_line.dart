import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class AddressLine extends StatelessWidget {
  final String label;
  final String content;
  final EdgeInsets margin;
  const AddressLine({
    super.key,
    required this.label,
    required this.content,
    this.margin = const EdgeInsets.only(bottom: 5),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text.rich(
        TextSpan(text: label, style: AppStyles.labelMedium, children: [
          const TextSpan(text: ": ", style: AppStyles.bodyLarge),
          TextSpan(text: content, style: AppStyles.bodyLarge)
        ]),
      ),
    );
  }
}
