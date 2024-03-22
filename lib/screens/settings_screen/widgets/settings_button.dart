import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  const SettingButton({
    super.key,
    required this.title,
    required this.iconAsset,
    required this.action,
    this.onPressed,
  });

  final String title;
  final String iconAsset;
  final Widget action;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
        onPressed: onPressed,
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.greyColor,
              ),
              alignment: Alignment.center,
              child: MyIcon(
                icon: iconAsset,
                height: 24,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 10),
            Text(title, style: Theme.of(context).textTheme.labelLarge),
            const Spacer(),
            action,
          ],
        ));
  }
}
