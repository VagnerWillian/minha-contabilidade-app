import 'package:intl/intl.dart';


extension IntegerExtension on int {
  String format(String pattern) {
    var f = NumberFormat(pattern);
    return f.format(this);
  }

  String get name =>
      {
        1: 'Janeiro',
        2: 'Fevereiro',
        3: 'Março',
        4: 'Abril',
        5: 'Maio',
        6: 'Junho',
        7: 'Julho',
        8: 'Agosto',
        9: 'Setembro',
        10: 'Outubro',
        11: 'Novembro',
        12: 'Dezembro'
      }[this] ??
      'ERRO';

  DateTime getFirstDate(DateTime? date) {
    if (this < 1 || this > 31) {
      throw 'integer $this is nothing between 1 and 31';
    }
    var today = date ?? DateTime.now();
    int day = 1;

    DateTime firstDate = DateTime(today.year, today.month, day);
    if (firstDate.isBefore(today) || firstDate == today) {
      firstDate = DateTime(today.year, today.month, day);
      day = this;
      if (firstDate.month == DateTime.february && day > 28) {
        if (isLeapYear(today.year)) {
          day = 29;
        } else {
          day = 28;
        }
      } else if (monthsWithThirtyDays().contains(firstDate.month) && day == 31) {
        day = 30;
      }
      firstDate = DateTime(firstDate.year, firstDate.month, day);
    }
    return firstDate;
  }

  List<int> monthsWithThirtyDays() {
    List<int> months = [4, 6, 9, 11];
    return months;
  }

  bool isLeapYear(int year) {
    if (year % 4 != 0) {
      return false;
    } else if (year % 100 != 0) {
      return true;
    } else if (year % 400 != 0) {
      return false;
    } else {
      return true;
    }
  }
}
