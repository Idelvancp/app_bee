import 'package:intl/intl.dart';

String formatDate(String dateString) {
  final date = DateTime.parse(dateString);
  return DateFormat('dd-MM-yyyy').format(date);
}
