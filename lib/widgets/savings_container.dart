import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/screens/modals/add_saving.dart';
import 'package:my_cashflow/screens/modals/use_saving.dart';
import 'package:my_cashflow/shared/styles.dart';

class SavingsContainer extends StatefulWidget {
  const SavingsContainer({super.key});

  @override
  State<SavingsContainer> createState() => _SavingsContainerState();
}

class _SavingsContainerState extends State<SavingsContainer> {
  void _showAddSaving(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: false,
      context: context,
      builder: (context) => const AddSaving(),
    );
  }

  void _showUseSaving(BuildContext context) {
    showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: false,
        context: context,
        builder: (context) => const UseSaving());
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
              'My Savings',
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
                      _showAddSaving(context);
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
                          'Add saving',
                          style: normalTextStyle.copyWith(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {
                      // _showAddExpence(context);
                      _showUseSaving(context);
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
                          'Use savings',
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
        ));
  }
}
