import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  const ColorItem(
      {super.key,
      required this.color,
      required this.isSelected,
      this.padding,
      this.onTap});
  final String color;
  final bool isSelected;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: padding,
        height: size.width * 0.06,
        width: size.width * 0.06,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * 0.06 / 2),
            border: Border.all(width: 1, color: AppColors.greyColor),
            color: Utils.hexToColor(color)),
        child: isSelected
            ? const Icon(
                Icons.check,
                size: 20,
                color: AppColors.greyColor,
              )
            : Container(),
      ),
    );
  }
}
