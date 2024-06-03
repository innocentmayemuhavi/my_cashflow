import 'package:flutter/material.dart';
import 'package:my_cashflow/screens/cards/transactioncard.dart';
import 'package:my_cashflow/shared/styles.dart';

class MyExpences extends StatefulWidget {
  const MyExpences({super.key});

  @override
  State<MyExpences> createState() => _MyExpencesState();
}

class _MyExpencesState extends State<MyExpences> {
  @override
  final List<int> _items = List<int>.generate(100, (index) => index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leadingWidth: 100,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 17,
              ),
              Text('Back')
            ],
          ),
        ),
        title: Text(
          'My Expenses',
          style: appbarTitleStyle,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return const TransactionCard();
        },
      ),
    );
  }
}
