import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/settings_element.dart';
import 'package:ecommerce_app/screens/profile_screen/widgets/profile_button.dart';
import 'package:ecommerce_app/screens/profile_screen/widgets/profile_information_card.dart';
import 'package:ecommerce_app/screens/profile_screen/widgets/profile_section_background.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.defaultPadding, vertical: 20),
          child: Column(children: [
            const ProfileInformationCard(),
            const SizedBox(height: 20),
            ProfileSectionBackground(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: settingsElements.length,
                    itemBuilder: (_, index) {
                      final element = settingsElements[index];

                      return ProfileButton(element: element);
                    })),
            const SizedBox(height: 20),
            ProfileSectionBackground(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: contactSettingsElements.length,
                    itemBuilder: (_, index) {
                      final element = contactSettingsElements[index];

                      return ProfileButton(element: element);
                    })),
          ]),
        ),
      ),
    );
  }
}
