import 'package:intl/intl.dart';

extension DatetTimeExtension on DateTime {
  String format(String pattern) {
    var f = DateFormat(pattern, 'pt_BR');
    return f.format(this);
  }

  DateTime getNextMonth() {
    int year = this.year;
    int month = this.month;

    if (month == 12) {
      year += 1;
      month = 1;
    } else {
      month += 1;
    }

    int day = this.day;
    int lastDayOfMonth = DateTime(year, month + 1, 0).day;
    day = day > lastDayOfMonth ? lastDayOfMonth : day;

    return DateTime.utc(year, month, day);
  }

  DateTime getPreviousMonth() {
    int year = this.year;
    int month = this.month;

    if (month == 1) {
      year -= 1;
      month = 12;
    } else {
      month -= 1;
    }

    int day = this.day;
    int lastDayOfMonth = DateTime(year, month + 1, 0).day;
    day = day > lastDayOfMonth ? lastDayOfMonth : day;

    return DateTime.utc(year, month, day);
  }
}
