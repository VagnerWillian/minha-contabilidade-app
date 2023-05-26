import 'package:intl/intl.dart';

extension NumExtension on num {
  String toRealFormat(){
    NumberFormat formatter = NumberFormat('R\$ #,##0.00', 'pt_BR');
    return formatter.format(this);
  }
}
