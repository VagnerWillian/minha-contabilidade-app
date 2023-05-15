import 'package:intl/intl.dart';

import '../../core.dart';

extension IntegerExtension on int {
  String format(String pattern) {
    var f = NumberFormat(pattern);
    return f.format(this);
  }

  String get toMonth =>
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
        12: 'December'
      }[this] ??
      'ERRO';

  DateTime getFirstDate() {
    if (this < 1 || this > 31) {
      throw 'integer $this is nothing between 1 and 31';
    }
    var today = AppConstants.todayNow;
    DateTime firstDate = DateTime(today.year, today.month, this);
    if (firstDate.isBefore(today)) {
      firstDate = DateTime(today.year, today.month + 1, this);
    }
    return firstDate;
  }
}
