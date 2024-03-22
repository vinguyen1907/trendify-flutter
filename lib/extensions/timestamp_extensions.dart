import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension TimestampExtensions on Timestamp {
  String getMonth() {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    String month = DateFormat("MMMM").format(dateTime);
    return month;
  }
}
