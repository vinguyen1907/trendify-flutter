import 'package:ecommerce_app/constants/enums/notification_type.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';

class UserNotification {
  final String id;
  final String userId;
  final String title;
  final String content;
  final DateTime createdAt;
  final NotificationType type;

  UserNotification({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.type,
  });

  factory UserNotification.fromMap(Map<String, dynamic> json) {
    NotificationType temp;
    switch ((json['type'] as String).toNotificationType()) {
      case NotificationType.promotion:
        temp = NotificationType.promotion;
      case NotificationType.advertisement:
        temp = NotificationType.advertisement;
      case NotificationType.statusOrder:
        temp = NotificationType.statusOrder;
      default:
        temp = NotificationType.promotion;
    }
    return UserNotification(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        content: json['content'],
        createdAt: json['createdAt'].toDate(),
        type: temp);
  }
}
