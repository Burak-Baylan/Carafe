import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart';

extension TimestampExtension on Timestamp {
  String get date {
    var dateFromTimeStamp = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
    return DateFormat("dd-MM-yyyy hh:mm a").format(dateFromTimeStamp);
  }

  String get getTimeAgo => GetTimeAgo.parse(toDate());
}
