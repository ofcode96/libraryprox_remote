// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:intl/intl.dart';

class TimeConverter {
  static String convertToRealTime(String timestemp) {
    final date = DateTime.fromMillisecondsSinceEpoch(
        double.parse(timestemp).toInt() * 1000);
    return DateFormat("yyyy-MM-dd").format(date);
  }

  static int daysBetween(String from, String to) {
    DateTime _from = DateTime.parse(from);
    DateTime _to = DateTime.parse(to);

    return (_to.difference(_from).inHours / 24).round();
  }

  static int convertToTimeStemps(String realTime) {
    final date = DateTime.parse(realTime);
    return date.millisecondsSinceEpoch;
  }
}
