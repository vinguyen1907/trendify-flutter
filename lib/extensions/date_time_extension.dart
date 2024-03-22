import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String formattedDate() {
    final formatter = DateFormat('d MMM, yyyy');
    return formatter.format(this);
  }

  String formattedNotificationDate() {
    final now = DateTime.now();
    if (now.difference(this).inHours < 24) {
      var hoursDifference = now.difference(this).inHours;
      if (hoursDifference > 0) {
        if (hoursDifference > 1) {
          return '$hoursDifference hours ago';
        } else if (hoursDifference == 1) {
          return '$hoursDifference hour ago';
        }
      } else {
        final minutesDifference = now.difference(this).inMinutes;
        if (minutesDifference > 1) {
          return '$minutesDifference minutes ago';
        } else if (minutesDifference == 1) {
          return '$minutesDifference minute ago';
        } else {
          return 'now';
        }
      }
    }
    final formatter = DateFormat('h:mm a, d MMM, yyyy');
    return formatter.format(this);
  }

  String toTransactionDateTimeFormat() {
    return DateFormat('MMM dd, yyyy | h:mm a').format(this);
  }

  String formattedDateChat() {
    final now = DateTime.now();
    if (year == now.year) {
      final yesterday = DateTime(now.year, now.month, now.day - 1);
      if (day == now.day) {
        final formatter = DateFormat('h:mm a');
        return formatter.format(this);
      } else if (day == yesterday.day) {
        final formatter = DateFormat('h:mm a');
        return 'Yesterday, ${formatter.format(this)}';
      } else {
        final formatter = DateFormat('dd MMM, h:mm a');
        return formatter.format(this);
      }
    } else {
      final formatter = DateFormat('dd MMM yyyy, h:mm a');
      return formatter.format(this);
    }
  }
}
