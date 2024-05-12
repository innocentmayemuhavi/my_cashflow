import 'package:flutter/material.dart';

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
