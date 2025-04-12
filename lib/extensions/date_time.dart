import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get formatDateTime => DateFormat('dd/MM/yyyy HH:mm').format(this);
}
