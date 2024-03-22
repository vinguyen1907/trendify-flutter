import 'package:ecommerce_app/common_widgets/my_icon_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/repositories/onboarding_repository.dart';
import 'package:ecommerce_app/screens/onboarding_screen/widgets/onboarding_clipper.dart';
import 'package:ecommerce_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routeName = '/onboarding-screen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.onboardingPadding),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    controller: controller,
                    itemCount: onboardingItems.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          ClipPath(
                            clipper: OnboardingClipper(),
                            child: Image.asset(
                              onboardingItems[index].image,
                              height: size.height * 0.55,
                              width: size.width -
                                  2 * AppDimensions.onboardingPadding,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            onboardingItems[index].title,
                            style: AppStyles.onboardingTitle,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            onboardingItems[index].description,
                            style: AppStyles.onboardingDescription,
                          ),
                        ],
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                      effect: const ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        dotColor: AppColors.darkGreyColor,
                        activeDotColor: AppColors.primaryColor,
                      ),
                      controller: controller,
                      count: onboardingItems.length),
                  MyIconButton(
                      onPressed: _onNextButtonPressed,
                      color: AppColors.primaryColor,
                      icon: SvgPicture.asset(AppAssets.icArrowRight),
                      size: 40)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onNextButtonPressed() {
    if (controller.page == onboardingItems.length - 1) {
      Utils().markAlreadyUsedOnboarding();
      Navigator.pushNamed(context, SignInScreen.routeName);
      return;
    }
    controller.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
