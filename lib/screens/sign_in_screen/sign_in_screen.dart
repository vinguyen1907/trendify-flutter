import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/common_widgets/loading_manager.dart';
import 'package:ecommerce_app/common_widgets/login_text_field.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/screens/sign_in_screen/widgets/or_text_divider.dart';
import 'package:ecommerce_app/screens/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = "/sign-in-screen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(body: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return LoadingManager(
          isLoading: state is Authenticating,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppDimensions.defaultPadding,
                  50, AppDimensions.defaultPadding, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset(AppAssets.icAppLogo),
                  SizedBox(height: size.height * 0.05),
                  Text("Welcome!",
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 5),
                  Text("Please login or sign up to continue our app",
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: size.height * 0.07),
                  Text("Email", style: Theme.of(context).textTheme.labelLarge),
                  LoginTextField(
                      hint: "Email",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false),
                  const SizedBox(height: 15),
                  Text("Password",
                      style: Theme.of(context).textTheme.labelLarge),
                  LoginTextField(
                      hint: "Password",
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true),
                  SizedBox(height: size.height * 0.05),
                  MyButton(
                      onPressed: _onSignInWithEmailAndPassword,
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: AppColors.whiteColor,
                            ),
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: OrTextDivider(),
                  ),
                  MyButton(
                    backgroundColor: const Color(0XFF3B5999),
                    onPressed: _onAuthWithFacebook,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppAssets.icFacebook),
                        const SizedBox(width: 5),
                        Text(
                          "Continue with Facebook",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: AppColors.greyColor),
                    ),
                    onPressed: _onSignInWithGoogle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.icGoogle,
                          height: 20,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Continue with Google",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: AppColors.greyTextColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("You don't have an account? ",
                          style: Theme.of(context).textTheme.bodyLarge),
                      InkWell(
                        onTap: _navigateToSignUpScreen,
                        child: Text("Sign up",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.primaryColor)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ));
  }

  void _onSignInWithEmailAndPassword() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      context.read<AuthBloc>().add(SignInWithEmailAndPassword(
          context: context,
          email: _emailController.text,
          password: _passwordController.text));
    }
  }

  void _onSignInWithGoogle() {
    context.read<AuthBloc>().add(AuthWithGoogle());
  }

  void _onAuthWithFacebook() {
    context.read<AuthBloc>().add(AuthWithFacebook());
  }

  void _navigateToSignUpScreen() {
    Navigator.pushNamed(context, SignUpScreen.routeName);
  }
}
