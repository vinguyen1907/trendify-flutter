import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/constants/enums/sort_type.dart';
import 'package:ecommerce_app/extensions/screen_extensions.dart';
import 'package:flutter/material.dart';

class SortTypeItem extends StatelessWidget {
  const SortTypeItem(
      {super.key,
      required this.sortType,
      required this.isSelected,
      this.onTap});
  final SortType sortType;
  final bool isSelected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 2,
                  color: !isSelected
                      ? AppColors.greyColor
                      : AppColors.primaryColor)),
          child: Center(
            child: Text(
              sortType.getName(),
              style: AppStyles.labelMedium.copyWith(
                  color: !isSelected
                      ? AppColors.primaryColor
                      : AppColors.whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
