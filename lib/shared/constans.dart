import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/expe_category.dart';

String SERVICE_ID = 'service_k2oj9vr';
String TEMPLETE_ID = 'template_3rtuvzr';
String PUBLIC_ID = 'q5VXEtcHUKdOXZrd9';
String PRIVATE_KEY = 'seA5FkaY3-dMFrRYBaOBl';

const List<String> categories = [
  'Food',
  'Transport',
  'Entertainment',
  'Health',
  'Education',
  'Shopping',
  'Others'
];
const List<String> colors = [
  'Red',
  'Blue',
  'Green',
  'Yellow',
  'Purple',
  'Orange',
  'Pink'
];

List<ExpeCategory> expeCategory = [
  ExpeCategory(
      id: '1',
      name: 'Food',
      color: Colors.green,
      icon: const Icon(Icons.food_bank)),
  ExpeCategory(
      id: '2',
      name: 'Transport',
      color: Colors.blue,
      icon: const Icon(CupertinoIcons.car_detailed)),
  ExpeCategory(
      id: '3',
      name: 'Entertainment',
      color: Colors.red,
      icon: const Icon(CupertinoIcons.music_mic)),
  ExpeCategory(
      id: '4',
      name: 'Shopping',
      color: Colors.purple,
      icon: const Icon(CupertinoIcons.shopping_cart)),
  ExpeCategory(
      id: '5',
      name: 'Others',
      color: Colors.grey,
      icon: const Icon(Icons.more_horiz)),
];
