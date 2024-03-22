import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/models/faq.dart';
import 'package:ecommerce_app/repositories/faqs_repository.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:flutter/material.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  static const String routeName = "/faqs-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const ScreenNameSection(label: "FAQs"),
        FutureBuilder<List<FAQ>>(
            future: FAQsRepository().getFAQs(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("Something went wrong"));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CustomLoadingWidget());
              } else {
                final List<FAQ> faqs = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: faqs.length,
                      itemBuilder: (_, index) {
                        final FAQ faq = faqs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.defaultPadding),
                          child: PrimaryBackground(
                            child: ExpansionTile(
                              shape: const RoundedRectangleBorder(),
                              title: Text(faq.question),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text(faq.answer,
                                      style: AppStyles.bodyLarge),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
            })
      ]),
    );
  }
}
