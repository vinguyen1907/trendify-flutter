import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/user_notification.dart';
import 'package:ecommerce_app/repositories/notification_repository.dart';
import 'package:ecommerce_app/screens/notification_screen/widgets/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenNameSection(label: 'Notification'),
          StreamBuilder<List<UserNotification>>(
              stream: NotificationRepository().fetchNotifications(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CustomLoadingWidget();
                }
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('No notification yet',
                          style: Theme.of(context).textTheme.bodyMedium),
                    );
                  }
                  return Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.defaultPadding),
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return NotificationItem(
                          userNotification: snapshot.data![index],
                        );
                      },
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
    ));
  }
}
