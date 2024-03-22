import 'package:ecommerce_app/models/user_notification.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationRepository {
  Stream<List<UserNotification>> fetchNotifications() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return notificationsRef
        .where('userId', whereIn: ['', userId])
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((e) =>
                UserNotification.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }
}
