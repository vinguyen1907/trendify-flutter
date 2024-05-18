import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SizeItem extends StatelessWidget {
  const SizeItem(
      {super.key, required this.value, this.onTap, required this.isSelected});
  final String value;
  final VoidCallback? onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        height: size.width * 0.12,
        width: size.width * 0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * 0.12 / 2),
            color: isSelected ? AppColors.primaryColor : Colors.white,
            border: Border.all(
                width: isSelected ? 0 : 1, color: AppColors.greyColor)),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
                color: !isSelected ? AppColors.primaryColor : Colors.white),
          ),
        ),
      ),
    );
  }
}
