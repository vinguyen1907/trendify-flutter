import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class MyOrderTabSelectionButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;
  final String label;

  const MyOrderTabSelectionButton({
    super.key,
    required this.isSelected,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return MyButton(
      borderRadius: 12,
      borderSide: !isSelected
          ? const BorderSide(
              width: 2,
              color: AppColors.darkGreyColor,
            )
          : BorderSide.none,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      backgroundColor: isSelected
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.secondaryContainer,
      onPressed: onPressed,
      child: Text(label,
          style: AppStyles.labelMedium.copyWith(
              fontSize: 12,
              height: 1,
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : AppColors.darkGreyColor)),
    );
  }
}
