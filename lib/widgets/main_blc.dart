import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/modals/add_income.dart';
import 'package:my_cashflow/modals/addexpence.dart';
import 'package:my_cashflow/services/firestore/streams/walletstream.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/utils.dart';
import 'package:provider/provider.dart';

class MainBlc extends StatefulWidget {
  const MainBlc({super.key});

  @override
  State<MainBlc> createState() => _MainBlcState();
}

class _MainBlcState extends State<MainBlc> {
  void _showAddIncome(BuildContext context, double balance) {
    showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return AddIncome(balance: balance);
        });
  }

  void _showAddExpence(BuildContext context, double balance) {
    showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return Addexpence(balance: balance);
        });
  }

  @override
  Widget build(BuildContext context) {
    User_Class user = Provider.of<User_Class>(context);
    return Container(
      height: MediaQuery.of(context).size.height * .21,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'My balance',
            style: normalTextStyle.copyWith(fontSize: 25),
          ),
          const SizedBox(height: 5),
          StreamBuilder<double>(
            stream: Walletstream().getBalance(user.uid),
            builder: (context, snapshot) {
              return Text(
                'Ksh. ${doublecurrencyFormatter(snapshot.data != null ? snapshot.data! : 0.0)}',
                style: normalTextStyle.copyWith(fontSize: 25),
              );
            },
          ),
          StreamBuilder<double>(
            stream: Walletstream().getBalance(user.uid),
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return const CircularProgressIndicator();
              // }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _showAddIncome(context,
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
                        _showAddExpence(context,
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
                            'Add expense',
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
      ),
    );
  }
}
