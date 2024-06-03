import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/screens/modals/add_income.dart';
import 'package:my_cashflow/screens/modals/addexpence.dart';
import 'package:my_cashflow/shared/styles.dart';

class MainBlc extends StatefulWidget {
  const MainBlc({super.key});

  @override
  State<MainBlc> createState() => _MainBlcState();
}

class _MainBlcState extends State<MainBlc> {
  void _showAddIncome(BuildContext context) {
    showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return const AddIncome();
        });
  }

  void _showAddExpence(BuildContext context) {
    showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return const Addexpence();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'My balance',
            style: normalTextStyle.copyWith(fontSize: 25),
          ),
          const SizedBox(height: 5),
          Text(
            'Ksh 10,000',
            style: boldTextStyle.copyWith(fontSize: 35),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _showAddIncome(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.arrow_down_left_circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Container(
                        width: 10,
                      ),
                      Text(
                        'Add income',
                        style: normalTextStyle.copyWith(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      )
                    ],
                  )),
              ElevatedButton(
                  onPressed: () {
                    _showAddExpence(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.arrow_up_right_circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Container(
                        width: 10,
                      ),
                      Text(
                        'Add expense',
                        style: normalTextStyle.copyWith(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
