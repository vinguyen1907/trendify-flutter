import 'package:flutter/material.dart';

import '../../../common_widgets/common_widgets.dart';
import '../../../constants/constants.dart';
import '../../../models/models.dart';

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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
        onPressed: () => element.onTap(context),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFE9F1FF),
              ),
              alignment: Alignment.center,
              child: MyIcon(
                icon: element.assetPath,
                height: 24,
                colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 10),
            Text(element.getTitle(context), style: Theme.of(context).textTheme.labelLarge),
            const Spacer(),
            MyIcon(
              icon: AppAssets.icChevronRight,
              height: 16,
              colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
            )
          ],
        ));
  }
}
