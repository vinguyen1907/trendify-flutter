// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/screens/chat_screen/chat_screen.dart';
import 'package:ecommerce_app/screens/e_wallet_screen/e_wallet_screen.dart';
import 'package:ecommerce_app/screens/faqs_screen/faqs_screen.dart';
import 'package:ecommerce_app/screens/favorite_screen/favorite_screen.dart';
import 'package:ecommerce_app/screens/my_cards_screen/my_cards_screen.dart';
import 'package:ecommerce_app/screens/my_order_screen/my_order_screen.dart';
import 'package:ecommerce_app/screens/personal_details_screen/personal_details_screen.dart';
import 'package:ecommerce_app/screens/settings_screen/settings_screen.dart';
import 'package:ecommerce_app/screens/shipping_addresses_screen/shipping_addresses_screen.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsElement {
  final String title;
  final String assetPath;
  final Function(BuildContext) onTap;
  final String Function(BuildContext) getTitle;
  SettingsElement({
    required this.title,
    required this.assetPath,
    required this.onTap,
    required this.getTitle,
  });
}

final List<SettingsElement> settingsElements = [
  SettingsElement(
    title: "Personal Details",
    getTitle: (context) => AppLocalizations.of(context)!.personalDetails,
    assetPath: AppAssets.icProfileTick,
    onTap: (context) {
      Navigator.pushNamed(context, PersonalDetailsScreen.routeName);
    },
  ),
  SettingsElement(
    title: "My Orders",
    getTitle: (context) => AppLocalizations.of(context)!.myOrders,
    assetPath: AppAssets.icBagBold,
    onTap: (context) {
      Navigator.pushNamed(context, MyOrderScreen.routeName);
    },
  ),
  // SettingsElement(
  //   title: "My Favorites",
  //   getTitle: (context) => AppLocalizations.of(context)!.myFavorites,
  //   assetPath: AppAssets.icHeartBold,
  //   onTap: (context) {
  //     Navigator.pushNamed(context, FavoriteScreen.routeName);
  //   },
  // ),
  SettingsElement(
    title: "Shipping Address",
    getTitle: (context) => AppLocalizations.of(context)!.shippingAddress,
    assetPath: AppAssets.icTruck,
    onTap: (context) {
      Navigator.pushNamed(context, ShippingAddressesScreen.routeName);
    },
  ),
  SettingsElement(
    title: "My Card",
    getTitle: (context) => AppLocalizations.of(context)!.myCards,
    assetPath: AppAssets.icCard,
    onTap: (context) {
      Navigator.pushNamed(context, MyCardsScreen.routeName);
    },
  ),
  // SettingsElement(
  //   title: "E-Wallet",
  //   getTitle: (context) => AppLocalizations.of(context)!.eWallet,
  //   assetPath: AppAssets.icWallet,
  //   onTap: (context) {
  //     Navigator.pushNamed(context, EWalletScreen.routeName);
  //   },
  // ),
  SettingsElement(
    title: "Settings",
    getTitle: (context) => AppLocalizations.of(context)!.settings,
    assetPath: AppAssets.icSetting,
    onTap: (context) {
      Navigator.pushNamed(context, SettingsScreen.routeName);
    },
  ),
];

final List<SettingsElement> contactSettingsElements = [
  SettingsElement(
      title: "FAQs",
      getTitle: (context) => AppLocalizations.of(context)!.faqs,
      assetPath: AppAssets.icInfo,
      onTap: (context) {
        Navigator.pushNamed(context, FAQsScreen.routeName);
      }),
  SettingsElement(
      title: "Privacy Policy",
      getTitle: (context) => AppLocalizations.of(context)!.privacyPolicy,
      assetPath: AppAssets.icShieldTick,
      onTap: (context) {
        Utils().launchUrl("https://www.termsfeed.com/live/fd3cdd13-7687-478e-8783-d06f5454ee5d");
      }),
  // SettingsElement(
  //     title: "Support",
  //     getTitle: (context) => AppLocalizations.of(context)!.support,
  //     assetPath: AppAssets.icHeadphone,
  //     onTap: (context) {
  //       Navigator.pushNamed(context, ChatScreen.routeName);
  //     }),
  // SettingsElement(
  //     title: "Logout", assetPath: AppAssets.icLogout, onTap: (context) {}),
];
