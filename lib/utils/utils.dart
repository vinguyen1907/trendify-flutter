import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/config/zalopay_config.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/utils/local_auth_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class Utils {
  static bool isEmailValid(String email) {
    final RegExp regex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }

  static void showSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer))));
  }

  static void showSnackBarSuccess(
      {required BuildContext context,
      required String message,
      required String title,
      Widget? actionButton}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          // height: size.height * 0.1,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.green),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        message,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
                if (actionButton != null) actionButton
              ]),
        )));
  }

  static String isValidPassword(String password) {
    String isValidValue = "valid";

    // Password must be at least 8 characters long
    if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }

    // Password must contain at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }

    // Password must contain at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    }

    // Password must contain at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one digit";
    }

    // Password must contain at least one special character
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return isValidValue;
  }

  Future<bool> isAlreadyUsedOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isAlreadyUsedOnboarding") ?? false;
  }

  Future<void> markAlreadyUsedOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isAlreadyUsedOnboarding", true);
  }

  static Color hexToColor(String color) {
    return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<bool> getNotificationMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("notificationMode") ?? true;
  }

  Future<void> changeNotificationMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool notificationMode = await getNotificationMode();
    prefs.setBool("notificationMode", !notificationMode);
  }

  Future<bool> getDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("darkMode") ?? false;
  }

  Future<void> changeDarkMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool darkMode = await getDarkMode();
    prefs.setBool("darkMode", !darkMode);
  }

  Future<void> launchUrl(String url) async {
    if (!await url_launcher.launchUrl(Uri.parse(url))) {
      throw Exception("Could not launch: $url");
    }
  }

  Future<void> showEnterPasscodeBottomSheet(
      {required BuildContext context,
      required String passcode,
      required VoidCallback onTruePasscode}) async {
    await showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.background,
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Enter your passcode",
                style: AppStyles.labelLarge,
              ),
              const SizedBox(height: 20),
              Pinput(
                validator: (value) {
                  if (value != passcode) {
                    return "Wrong passcode!";
                  }
                  return null;
                },
                errorTextStyle: AppStyles.labelMedium.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w500),
                autofocus: true,
                length: 6,
                obscureText: true,
                crossAxisAlignment: CrossAxisAlignment.center,
                onCompleted: (value) {
                  if (value == passcode) {
                    onTruePasscode();
                  }
                },
              ),
              const SizedBox(height: 20),
              FutureBuilder<bool>(
                future: LocalAuthUtil().isBiometricsAvailable(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == true) {
                      return InkWell(
                        onTap: () {
                          LocalAuthUtil()
                              .authenticateWithBiometrics()
                              .then((value) {
                            if (value) {
                              onTruePasscode();
                            } else {
                              Utils.showSnackBar(
                                  context: context,
                                  message: "Your device does not support");
                            }
                          });
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyIcon(icon: AppAssets.icFingerprint),
                            SizedBox(width: 10),
                            Text("Use fingerprint"),
                          ],
                        ),
                      );
                    }
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> showPayingDialog({required BuildContext context}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20)),
            child: Lottie.asset(AppAssets.lottieTransactionProcess),
          ),
        );
      },
    );
  }

  Future<void> showSuccessDialog(
      {required BuildContext context,
      required Widget icon,
      required VoidCallback onButtonPressed,
      required String buttonText,
      required String description}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: AppDimensions.circleCorners),
                    alignment: Alignment.center,
                    child: icon,
                  ),
                  const SizedBox(height: 20),
                  const Text("Successful!",
                      textAlign: TextAlign.center,
                      style: AppStyles.displayLarge),
                  const SizedBox(height: 20),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: AppStyles.bodyLarge,
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    onPressed: onButtonPressed,
                    child: Text(
                      buttonText,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  int transIdDefault = 1;
  String getAppTransId() {
    if (transIdDefault >= 100000) {
      transIdDefault = 1;
    }

    transIdDefault += 1;
    var timeString = formatDateTime(DateTime.now(), "yyMMdd_hhmmss");
    return sprintf("%s%06d", [timeString, transIdDefault]);
  }

  String getBankCode() => "zalopayapp";
  String getDescription(String apptransid) =>
      "Ecommerce App thanh toán cho đơn hàng  #$apptransid";

  String getMacCreateOrder(String data) {
    var hmac = Hmac(sha256, utf8.encode(ZaloPayConfig.key1));
    return hmac.convert(utf8.encode(data)).toString();
  }

  /// Function Format DateTime to String with layout string
  String formatNumber(double value) {
    final f = NumberFormat("#,###", "vi_VN");
    return f.format(value);
  }

  /// Function Format DateTime to String with layout string
  String formatDateTime(DateTime dateTime, String layout) {
    return DateFormat(layout).format(dateTime).toString();
  }
}
