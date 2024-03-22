import 'package:ecommerce_app/constants/enums/notification_type.dart';

extension NotificationTypeExt on NotificationType {
  String toNotificationTypeString() {
    switch (this) {
      case NotificationType.promotion:
        return "promotion";
      case NotificationType.advertisement:
        return "advertisement";
      case NotificationType.statusOrder:
        return "statusOrder";
      default:
        return "";
    }
  }
}
