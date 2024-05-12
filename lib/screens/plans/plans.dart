import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/screens/createplan/createplan.dart';
import 'package:my_cashflow/shared/styles.dart';

class Plans extends StatefulWidget {
  const Plans({super.key});

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  final List<String> _plans = ['Plan 1', 'Plan 2', 'Plan 3'];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sorry, you have no plans yet',
              style: normalTextStyle.copyWith(fontSize: 20)),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const CreatePlan()),
              );
            },
            icon: const Icon(
              Icons.add,
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}
