import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/search_screen/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.defaultPadding, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.home,
            style: AppStyles.displayLarge,
          ),
          Text(
            AppLocalizations.of(context)!.ourFashionsApp,
            style: AppStyles.displayMedium,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GestureDetector(
              onTap: () => showSearch(
                  context: context, delegate: CustomSearchDelegate()),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 50,
                decoration: BoxDecoration(
                    color: AppColors.greyColor,
                    borderRadius: BorderRadius.circular(40)),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: MyIcon(
                            icon: AppAssets.icSearch,
                            colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                          )),
                      hintStyle: const TextStyle(color: AppColors.primaryHintColor),
                      hintText: "Search...",
                      border: InputBorder.none),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
