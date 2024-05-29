import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileDetailsInformation extends StatelessWidget {
  const ProfileDetailsInformation({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: AppColors.greyTextColor)),
        SizedBox(
          width: size.width * 0.6,
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyColor),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyColor),
              ),
            ),
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}
