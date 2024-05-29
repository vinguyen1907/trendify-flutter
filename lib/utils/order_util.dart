import 'package:uuid/uuid.dart';

class OrderUtil {
  String generateOrderNumber(String userId) {
    final time = DateTime.now();
    final timeComponent = (time.year % 1000).toString() +
        time.month.toString() +
        time.day.toString() +
        time.hour.toString() +
        time.minute.toString() +
        time.second.toString();

    final randomComponent = const Uuid()
        .v4()
        .split('-')
        .first; // Generate a random UUID and take the first part

    int userIdLength = userId.length;
    return userId.substring(0, userIdLength >= 4 ? 4 : userIdLength) + timeComponent + randomComponent;
  }
}
