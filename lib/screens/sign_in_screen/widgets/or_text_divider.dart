import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class OrTextDivider extends StatelessWidget {
  const OrTextDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Flexible(
          flex: 1,
          child: Divider(
            color: AppColors.darkGreyColor,
          ),
        ),
        Text("or"),
        Flexible(
          flex: 1,
          child: Divider(
            color: AppColors.darkGreyColor,
          ),
        ),
      ],
    );
  }
}
