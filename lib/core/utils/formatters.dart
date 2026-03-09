import 'package:intl/intl.dart';

class Formatters {
  static String currency(double value) =>
      NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(value);

  static String number(num value) => NumberFormat('#,##0').format(value);

  static String date(DateTime dt) => DateFormat('MMM dd, yyyy').format(dt);

  static String dateTime(DateTime dt) =>
      DateFormat('MMM dd, yyyy – hh:mm a').format(dt);

  static String shortDate(DateTime dt) => DateFormat('dd/MM/yy').format(dt);
}
