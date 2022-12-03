import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toFormatedString() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
