import 'package:flutter/material.dart';
import 'package:my_cashflow/shared/styles.dart';

class IncomesPage extends StatefulWidget {
  const IncomesPage({super.key});

  @override
  State<IncomesPage> createState() => _IncomesPageState();
}

class _IncomesPageState extends State<IncomesPage> {
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
          'My Incomes',
          style: appbarTitleStyle,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shopping',
                          style: normalTextStyle.copyWith(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Ksh 5,000',
                          style: boldTextStyle.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Dec 12th 2024',
                      style: normalTextStyle.copyWith(
                          fontSize: 15, color: Colors.grey),
                    ),
                    Text(
                      '12:00 PM',
                      style: normalTextStyle.copyWith(
                          fontSize: 15, color: Colors.grey),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
