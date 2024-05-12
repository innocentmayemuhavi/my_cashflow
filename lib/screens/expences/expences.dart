import 'package:flutter/material.dart';

class MyExpences extends StatefulWidget {
  const MyExpences({super.key});

  @override
  State<MyExpences> createState() => _MyExpencesState();
}

class _MyExpencesState extends State<MyExpences> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('My Expences Page'));
  }
}
