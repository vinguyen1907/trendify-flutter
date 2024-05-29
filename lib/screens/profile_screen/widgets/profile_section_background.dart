import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileSectionBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  const ProfileSectionBackground({
    super.key,
    required this.child,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin,
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.darkGreyColor, width: 1.5),
            borderRadius: BorderRadius.circular(18)),
        child: child);
  }
}
