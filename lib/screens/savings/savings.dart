import 'package:flutter/material.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/widgets/charts/savings/monthly.dart';
import 'package:my_cashflow/widgets/charts/savings/weekily.dart';
import 'package:my_cashflow/widgets/savings_container.dart';

class SavingsPage extends StatefulWidget {
  const SavingsPage({super.key});

  @override
  State<SavingsPage> createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
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
          'My Savings',
          style: appbarTitleStyle,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const SavingsContainer(),
          const SizedBox(height: 20),
          Text(
            'Weeky savings',
            style: normalTextStyle,
          ),
          const SizedBox(height: 20),
          const WeeklyChart(),
          const SizedBox(height: 20),
          Text(
            'Monthly savings',
            style: normalTextStyle,
          ),
          const SizedBox(height: 20),
          const MonthlyChart()
        ],
      ),
    );
  }
}
