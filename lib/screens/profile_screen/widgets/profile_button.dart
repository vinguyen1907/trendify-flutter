import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/models/settings_element.dart';
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.element,
  });

  final SettingsElement element;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
        onPressed: () => element.onTap(context),
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
                icon: element.assetPath,
                height: 24,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 10),
            Text(element.getTitle(context),
                style: Theme.of(context).textTheme.labelLarge),
            const Spacer(),
            const MyIcon(
              icon: AppAssets.icChevronRight,
              height: 16,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            )
          ],
        ));
  }
}
