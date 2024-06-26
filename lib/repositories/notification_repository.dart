import 'package:ecommerce_app/models/user_notification.dart';
import 'package:ecommerce_app/constants/constants.dart';

class NotificationRepository {
  Stream<List<UserNotification>> fetchNotifications() {
    final userId = 852;
    return notificationsRef
        .where('userId', whereIn: ['', userId])
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((e) => UserNotification.fromMap(e.data() as Map<String, dynamic>)).toList());
  }
}
