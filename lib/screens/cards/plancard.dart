import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/plans_model.dart';
import 'package:my_cashflow/screens/singleplan/singleplan.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/progress_calc.dart';
import 'package:my_cashflow/utils/utils.dart';

class Plancard extends StatefulWidget {
  const Plancard({super.key, required this.plan});
  final PlansModel plan;

  @override
  State<Plancard> createState() => _PlancardState();
}

class _PlancardState extends State<Plancard> {
  void _showModalSheet() {
    showModalBottomSheet(
        showDragHandle: true,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delete Plan',
                  style: normalTextStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Text(
                  'Are you sure you want to delete this plan?',
                  style: normalTextStyle.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: const Text('Delete Plan'),
    //       content: const Text('Are you sure you want to delete this plan?'),
    //       actions: <Widget>[
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: const Text('No'),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: const Text('Yes'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        _showModalSheet();
      },
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => ViewPlan(plan: widget.plan)),
        );
      },
      child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(right: 10, bottom: 15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 130,
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#${widget.plan.category}',
                style: normalTextStyle.copyWith(
                    color: getColor(widget.plan.color.toLowerCase()),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                widget.plan.planName,
                style: normalTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ksh ${curencyFommater(widget.plan.spent.toString())}',
                    style: boldTextStyle.copyWith(fontSize: 15),
                  ),
                  Text(
                    'Ksh ${curencyFommater(widget.plan.amount.toString())}',
                    style: normalTextStyle.copyWith(
                        fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                color: Colors.red,
                minHeight: 10,
                borderRadius: BorderRadius.circular(10),
                value: calculateProgress(
                    double.parse(widget.plan.spent.toString()),
                    double.parse(widget.plan.amount
                        .toString())), // Update this value (0.0 to 1.0) to reflect the current progress
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  getColor(widget.plan.color.toLowerCase()),
                ),
              ),
            ],
          )),
    );
  }
}
