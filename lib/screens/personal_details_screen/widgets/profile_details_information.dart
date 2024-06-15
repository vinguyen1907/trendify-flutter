import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileDetailsInformation extends StatelessWidget {
  const ProfileDetailsInformation(
      {super.key,
      required this.label,
      required this.controller,
      required this.hintText,
      this.validator,
      this.keyboardType,
      this.onChanged,
      this.enabled = true});

  final String label;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      enabled: enabled,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        hintText: hintText,
        label: Text(label),
        floatingLabelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).primaryColor),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryHintColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryHintColor),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
