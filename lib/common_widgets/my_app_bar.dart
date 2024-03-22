import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final bool hideDefaultLeadingButton;

  const MyAppBar({
    super.key,
    this.actions,
    this.hideDefaultLeadingButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!hideDefaultLeadingButton)
              SizedBox(
                height: 35,
                width: 35,
                child: ElevatedButton(
                  onPressed: () => _popToPreviousScreen(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    // backgroundColor:
                    //     Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.icArrowLeft,
                    // width: 20,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onSecondary,
                        BlendMode.srcIn),
                  ),
                ),
              ),
            const Spacer(),
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }

  _popToPreviousScreen(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
