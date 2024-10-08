import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color getColor(String colorName) {
  switch (colorName) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'yellow':
      return Colors.yellow;
    case 'purple':
      return Colors.purple;
    case 'orange':
      return Colors.orange;
    case 'pink':
      return Colors.pink;
    case 'white':
      return Colors.white;
    default:
      return Colors.black;
  }
}

String curencyFommater(String amount) {
  return amount.isNotEmpty
      ? NumberFormat.currency(locale: 'en_US', name: 'KES', symbol: '')
          .format(int.parse(amount))
      : '0.00';
}

String doublecurrencyFormatter(double amount) {
  return amount != null
      ? NumberFormat.currency(locale: 'en_US', name: 'KES', symbol: '')
          .format(amount)
      : '0.00';
}