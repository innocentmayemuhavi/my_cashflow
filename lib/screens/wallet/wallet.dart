import 'package:flutter/material.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/widgets/charts/expenses_savings/line_chart.dart';
import 'package:my_cashflow/widgets/charts/expenses_savings/monthly_chart.dart';
import 'package:my_cashflow/widgets/main_blc.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        const MainBlc(),
        const SizedBox(
          height: 20,
        ),
        Text('Weekly Savings', style: normalTextStyle),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        const MyLineChart(),
        const SizedBox(
          height: 20,
        ),
        Text('Monthy Savings', style: normalTextStyle),
        const SizedBox(
          height: 20,
        ),
        const MonthlyChart()
      ],
    );
  }
}
