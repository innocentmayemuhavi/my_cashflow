import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('EEEE, dd/MM/yyyy'); // Updated format
  return formatter.format(date);
}
