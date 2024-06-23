import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/modals/add_saving.dart';
import 'package:my_cashflow/modals/use_saving.dart';
import 'package:my_cashflow/services/firestore/streams/savings_stream.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/utils.dart';
import 'package:provider/provider.dart';

class SavingsContainer extends StatefulWidget {
  const SavingsContainer({super.key});

  @override
  State<SavingsContainer> createState() => _SavingsContainerState();
}

class _SavingsContainerState extends State<SavingsContainer> {
  void _showAddSaving(BuildContext context, double balance) {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: false,
      context: context,
      builder: (context) => AddSaving(balance: balance),
    );
  }

  void _showUseSaving(BuildContext context, double balance) {
    showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: false,
        context: context,
        builder: (context) => UseSaving(
              balance: balance,
            ));
  }

  @override
  Widget build(BuildContext context) {
    User_Class user = Provider.of<User_Class>(context);
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
            StreamBuilder<double>(
              stream: SavingsStreams().getSavingBalance(user.uid),
              builder: (context, snapshot) {
                return Text(
                  'Ksh. ${doublecurrencyFormatter(snapshot.data != null ? snapshot.data! : 0.0)}',
                  style: normalTextStyle.copyWith(fontSize: 25),
                );
              },
            ),
            StreamBuilder<double>(
              stream: SavingsStreams().getSavingBalance(user.uid),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return const CircularProgressIndicator();
                // }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _showAddSaving(context,
                              snapshot.data != null ? snapshot.data! : 0.0);
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
                              'Add Saving',
                              style: normalTextStyle.copyWith(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            )
                          ],
                        )),
                    ElevatedButton(
                        onPressed: () {
                          _showUseSaving(context,
                              snapshot.data == null ? 0.0 : snapshot.data!);
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
                              'Use Saving',
                              style: normalTextStyle.copyWith(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            )
                          ],
                        ))
                  ],
                );
              },
            ),
          ],
        ));
  }
}
