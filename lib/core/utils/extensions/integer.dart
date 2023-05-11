import 'package:intl/intl.dart';

extension IntegerExtension on int {
  String format(String pattern){
    var f = NumberFormat(pattern);
    return f.format(this);
  }
}
