import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyProduct extends StatelessWidget {
  const EmptyProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: ScreenNameSection(
              label: 'Favorite Products',
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          SvgPicture.asset(
            AppAssets.imgNoFavorite,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Empty Favorite Product",
            style: AppStyles.labelLarge,
          )
        ],
      ),
    );
  }
}
