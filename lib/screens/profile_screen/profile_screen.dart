import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/models.dart';
import 'widgets/widgets.dart';

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
