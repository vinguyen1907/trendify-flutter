import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/blocs/language_bloc/language_bloc.dart';
import 'package:ecommerce_app/blocs/theme_bloc/theme_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/constants/enums/language.dart';
import 'package:ecommerce_app/screens/profile_screen/widgets/profile_section_background.dart';
import 'package:ecommerce_app/screens/select_language_screen/select_language_screen.dart';
import 'package:ecommerce_app/screens/settings_screen/widgets/my_switch_button.dart';
import 'package:ecommerce_app/screens/settings_screen/widgets/settings_button.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String routeName = "/settings-screen";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationMode = true;

  @override
  void initState() {
    super.initState();
    _getNotificationMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenNameSection(label: AppLocalizations.of(context)!.settings),
          ProfileSectionBackground(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding),
              child: Column(
                children: [
                  SettingButton(
                      title: AppLocalizations.of(context)!.language,
                      iconAsset: AppAssets.icGlobal,
                      onPressed: _onNavigateToSelectLanguageScreen,
                      action: BlocBuilder<LanguageBloc, LanguageState>(
                        builder: (context, state) {
                          if (state is LanguageLoaded) {
                            return Row(
                              children: [
                                Text(
                                    languageToLanguageName[
                                        languageCodeToLanguage[state.locale]!]!,
                                    style: AppStyles.bodyLarge),
                                const SizedBox(width: 10),
                                const MyIcon(
                                    icon: AppAssets.icChevronRight, height: 14)
                              ],
                            );
                          }
                          return Container();
                        },
                      )),
                  SettingButton(
                      title: AppLocalizations.of(context)!.notification,
                      iconAsset: AppAssets.icNotification,
                      action: MySwitchButton(
                        value: notificationMode,
                        onChanged: (value) => _onChangeNotificationMode(),
                      )),
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return SettingButton(
                          title: AppLocalizations.of(context)!.darkMode,
                          iconAsset: AppAssets.icMoon,
                          action: MySwitchButton(
                            value: state.themeMode == ThemeMode.dark,
                            onChanged: (value) =>
                                _onChangeDarkMode(value, context),
                          ));
                    },
                  ),
                  SettingButton(
                      title: AppLocalizations.of(context)!.helpCenter,
                      iconAsset: AppAssets.icInfo,
                      action: const SizedBox()),
                ],
              )),
          const Spacer(),
          MyButton(
            margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding),
            borderRadius: 12,
            onPressed: _onLogOut,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyIcon(
                  icon: AppAssets.icLogout,
                  colorFilter:
                      ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
                ),
                const SizedBox(width: 10),
                Text(AppLocalizations.of(context)!.logOut,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.whiteColor)),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _onChangeNotificationMode() {
    setState(() {
      notificationMode = !notificationMode;
    });
    Utils().changeNotificationMode();
  }

  _getNotificationMode() async {
    final notificationMode = await Utils().getNotificationMode();
    setState(() {
      this.notificationMode = notificationMode;
    });
  }

  void _onChangeDarkMode(bool isDark, BuildContext context) {
    context
        .read<ThemeBloc>()
        .add(ChangeTheme(themeMode: isDark ? ThemeMode.dark : ThemeMode.light));
  }

  void _onLogOut() {
    context.read<AuthBloc>().add(LogOut());
  }

  void _onNavigateToSelectLanguageScreen() {
    Navigator.pushNamed(context, SelectLanguageScreen.routeName);
  }
}
