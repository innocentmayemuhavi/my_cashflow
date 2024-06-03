import 'package:flutter/material.dart';

var normalTextStyle = const TextStyle(fontFamily: 'Kanit', fontSize: 18);

var boldTextStyle = const TextStyle(
    fontFamily: 'Kanit', fontSize: 18, fontWeight: FontWeight.bold);
var appbarTitleStyle = const TextStyle(
  fontFamily: 'Kanit',
  fontSize: 20,
  fontWeight: FontWeight.w500,
);
var elevatedButtonStyle = ElevatedButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
  ),
);
var normalButtonStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(25),
  border: Border.all(color: Colors.grey),
);
