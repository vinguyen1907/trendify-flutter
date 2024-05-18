import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/blocs/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/screens/main_screen/main_screen.dart';
import 'package:ecommerce_app/screens/onboarding_screen/onboarding_screen.dart';
import 'package:ecommerce_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool firstTime =
      true; // It is used for marking this is the first time load user for whole app.
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
              if (state is Unauthenticated) {
                firstTime = true;
                Utils().isAlreadyUsedOnboarding().then((value) {
                  if (value) {
                    Navigator.pushNamed(
                      context,
                      SignInScreen.routeName,
                      // (route) =>
                      //     route.settings.name == SplashScreen.routeName
                    );
                  } else {
                    Navigator.pushNamedAndRemoveUntil(context,
                        OnboardingScreen.routeName, (route) => route.isFirst);
                  }
                });
              } else if (state is Authenticated) {
                context.read<UserBloc>().add(LoadUser());
              } else if (state is AuthenticationFailure) {
                Utils.showSnackBar(context: context, message: state.message);
              }
            },
            child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
                  if (state is UserLoaded && firstTime) {
              firstTime = false;
              context.read<HomeBloc>().add(const LoadHome());
              context.read<CartBloc>().add(LoadCart());
              context.read<PlaceOrderBloc>().add(UpdateAddress(state.user.defaultShippingAddress));

              // Only the first time load user, we need to navigate to MainScreen
              Navigator.pushReplacementNamed(context, MainScreen.routeName);
              // Navigator.pushNamedAndRemoveUntil(context,
              //     MainScreen.routeName, (route) => route.isFirst);
                  } else if (state is UserError) {
                    Utils.showSnackBar(
                        context: context,
                        message: "Some error occurred. Please sign in again! --- ${state.message}");
                    Navigator.pushNamedAndRemoveUntil(context,
                        SignInScreen.routeName, (route) => route.isFirst);
                  }
                },
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Spacer(),
              Center(
                child: SvgPicture.asset(AppAssets.icAppLogo, height: 100),
              ),
              const Spacer(),
              Text(
                "TRENDIFY",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(letterSpacing: 8, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
