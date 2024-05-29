import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/my_icon_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/enums/notification_type.dart';
import 'package:ecommerce_app/extensions/date_time_extension.dart';
import 'package:ecommerce_app/models/user_notification.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.userNotification});
  final UserNotification userNotification;
  @override
  Widget build(BuildContext context) {
    String icon;
    switch (userNotification.type) {
      case NotificationType.promotion:
        icon = AppAssets.icPromotion;
      case NotificationType.statusOrder:
        icon = AppAssets.icTruck;
      case NotificationType.advertisement:
        icon = AppAssets.icBagBold;
      default:
        icon = AppAssets.icPromotion;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyIconButton(
              onPressed: () {},
              icon: MyIcon(
                icon: icon,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onPrimaryContainer,
                    BlendMode.srcIn),
              ),
              size: 50,
              color: Theme.of(context).colorScheme.primaryContainer),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userNotification.title,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  userNotification.content,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  userNotification.createdAt.formattedNotificationDate(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.greyTextColor.withOpacity(0.6)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
