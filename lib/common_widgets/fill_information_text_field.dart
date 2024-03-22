import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class FillInformationTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final EdgeInsets? margin;
  final String? Function(String?)? validator;

  const FillInformationTextField({
    super.key,
    required this.label,
    required this.controller,
    this.margin = const EdgeInsets.only(bottom: 20),
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          labelText: label,
          labelStyle: AppStyles.labelMedium.copyWith(
            color: AppColors.darkGreyColor,
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.darkGreyColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.darkGreyColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.darkGreyColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.darkGreyColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
