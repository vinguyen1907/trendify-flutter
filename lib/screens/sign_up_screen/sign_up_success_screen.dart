import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  static const routeName = "/sign-up-success-screen";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Lottie.asset(
          AppAssets.lottieSuccess,
          width: size.width / 2,
          fit: BoxFit.fitWidth,
        ),
        const Text(
          "Successful!",
          style: AppStyles.displayLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Text(
            "You have successfully registered in our app and start working in it.",
            textAlign: TextAlign.center,
            style: AppStyles.bodyLarge,
          ),
        ),
        const Spacer(),
        MyButton(
          margin: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding,
          ),
          onPressed: () => _onStartShopping(context),
          child: Text("Start Shopping",
              style: AppStyles.labelLarge.copyWith(
                color: AppColors.whiteColor,
              )),
        ),
        SizedBox(height: size.height * 0.1),
      ],
    ));
  }

  _onStartShopping(BuildContext context) {
    context.read<AuthBloc>().add(StartShopping());
  }
}
