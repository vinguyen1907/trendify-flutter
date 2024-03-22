import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle displayLarge = TextStyle(
      fontSize: 25, fontWeight: FontWeight.bold, color: AppColors.primaryColor);
  static const TextStyle displayMedium = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.greyTextColor);
  static const TextStyle displaySmall = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.primaryColor);
  static const TextStyle headlineLarge = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primaryColor);
  static const TextStyle headlineMedium = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  static const TextStyle titleMedium = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  static const TextStyle titleSmall = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.primaryColor);
  static const TextStyle labelLarge = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  static const TextStyle labelMedium = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryColor);
  static const TextStyle bodyLarge = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.greyTextColor);
  static const TextStyle bodyMedium = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: AppColors.greyTextColor);
  static const TextStyle onboardingTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle onboardingDescription = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.greyTextColor,
  );

  static final OutlineInputBorder paymentEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.grey),
  );
  static final OutlineInputBorder paymentFocusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.blue),
  );
  static final OutlineInputBorder paymentErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.red),
  );
  static final OutlineInputBorder paymentFocusedErrorBorder =
      OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide:
        const BorderSide(color: Color.fromARGB(255, 195, 35, 35), width: 1.5),
  );
  static OutlineInputBorder topUpEnabledBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      borderRadius: BorderRadius.circular(25));
  static OutlineInputBorder topUpErrorBorder = OutlineInputBorder(
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 195, 35, 35), width: 2),
      borderRadius: BorderRadius.circular(25));
}
