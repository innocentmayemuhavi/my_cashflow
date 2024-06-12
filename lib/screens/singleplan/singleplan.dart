import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/plan_finance_model.dart';
import 'package:my_cashflow/models/plans_model.dart';
import 'package:my_cashflow/models/transaction_model.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/screens/cards/transactioncard.dart';
import 'package:my_cashflow/screens/modals/add_deposit.dart';
import 'package:my_cashflow/screens/modals/addplanbudget.dart';
import 'package:my_cashflow/screens/modals/deleteplan.dart';
import 'package:my_cashflow/services/firestore/streams/plans_streams.dart';
import 'package:my_cashflow/services/firestore/streams/walletstream.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/date_formatter.dart';
import 'package:my_cashflow/utils/get_col_icon.dart';
import 'package:my_cashflow/utils/percentage_spent_calc.dart';
import 'package:my_cashflow/utils/progress_calc.dart';
import 'package:my_cashflow/utils/utils.dart';
import 'package:provider/provider.dart';

class ViewPlan extends StatefulWidget {
  const ViewPlan({super.key, required this.plan});
  final PlansModel plan;

  @override
  State<ViewPlan> createState() => _ViewPlanState();
}

class _ViewPlanState extends State<ViewPlan> {
  void _showAddTransaction(BuildContext context, uid, budget) {
    showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: false,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        builder: (context) {
          return AddPlanTransaction(
              budget: int.parse(budget.toString()),
              uid: uid,
              planId: widget.plan.id);
        });
  }

  void _showDeposit(BuildContext context, uid, budget) {
    showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: false,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        builder: (context) {
          return PlanDeposit(
            uid: uid,
            planId: widget.plan.id,
            budget: budget,
          );
        });
  }

  void _showDelete(BuildContext context) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) {
          return Deleteplan(
            planId: widget.plan.id,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    User_Class user = Provider.of<User_Class>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          leadingWidth: 70,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                    ),
                  )
                ],
              )),
          actions: [
            IconButton(
                onPressed: () {
                  _showDelete(context);
                },
                icon: const Icon(CupertinoIcons.delete_simple))
          ],
          title: Text(
            'View Plan',
            style: appbarTitleStyle,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(
                        size: 100,
                        widget.plan.category == 'Income'
                            ? CupertinoIcons.arrow_down_left_circle
                            : widget.plan.category == 'Food'
                                ? Icons.food_bank
                                : widget.plan.category == 'Shopping'
                                    ? CupertinoIcons.shopping_cart
                                    : widget.plan.category == 'Transport'
                                        ? CupertinoIcons.car_detailed
                                        : widget.plan.category ==
                                                'Entertainment'
                                            ? CupertinoIcons.music_mic
                                            : Icons.more_horiz,
                        color: getColor(widget.plan.color.toLowerCase()),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '#${widget.plan.category}',
                      style: boldTextStyle.copyWith(
                          color: getColor(widget.plan.color.toLowerCase())),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      widget.plan.planName,
                      style: boldTextStyle.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      overflow: TextOverflow.fade,
                      widget.plan.description,
                      style: boldTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Created on ${formatDate(widget.plan.startDate)}',
                      style: normalTextStyle.copyWith(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'End  at ${formatDate(widget.plan.endDate)}',
                      style: normalTextStyle.copyWith(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Budget info',
                      style: normalTextStyle.copyWith(color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder(
                          stream: PlansStreams()
                              .getPlanFinance(user.uid, widget.plan.id),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data == null) {
                              return Text(
                                'Ksh 0.0',
                                style: boldTextStyle.copyWith(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }

                            return Text(
                              'Ksh  ${snapshot.data['amount'].toString()}',
                              style: boldTextStyle.copyWith(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          },
                        ),
                        StreamBuilder<double>(
                          stream: Walletstream().getBalance(user.uid),
                          builder: (context, snapshot) {
                            return TextButton(
                                onPressed: () {
                                  _showDeposit(
                                      context, user.uid, snapshot.data);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.arrow_down_left_circle,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text('Deposit',
                                        style: normalTextStyle.copyWith(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ))
                                  ],
                                ));
                          },
                        ),
                      ],
                    ),
                    StreamBuilder(
                      stream: PlansStreams()
                          .getPlanFinance(user.uid, widget.plan.id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null) {
                          return LinearProgressIndicator(
                            color: Colors.red,
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(10),
                            value:
                                0, // Update this value (0.0 to 1.0) to reflect the current progress
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                                getColor(widget.plan.color.toLowerCase())),
                          );
                        }

                        return LinearProgressIndicator(
                          color: Colors.red,
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(10),
                          value: calculateProgress(
                              double.parse(snapshot.data['spent'].toString()),
                              double.parse(snapshot.data['amount']
                                  .toString())), // Update this value (0.0 to 1.0) to reflect the current progress
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              getColor(widget.plan.color.toLowerCase())),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: PlansStreams()
                          .getPlanFinance(user.uid, widget.plan.id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ksh ${curencyFommater(widget.plan.spent.toString())}',
                                  style: normalTextStyle.copyWith(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${calculatePercentageSpent(double.parse(widget.plan.spent.toString()), double.parse(widget.plan.amount.toString())).toStringAsFixed(2)}%',
                                  style: normalTextStyle.copyWith(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ]);
                        }

                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ksh ${snapshot.data['spent']}',
                                style: normalTextStyle.copyWith(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${calculatePercentageSpent(double.parse(snapshot.data['spent'].toString()), double.parse(snapshot.data['amount'].toString())).toStringAsFixed(2)}%',
                                style: normalTextStyle.copyWith(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ]);
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tansactions'),
                StreamBuilder(
                  stream:
                      PlansStreams().getPlanFinance(user.uid, widget.plan.id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return TextButton(
                          onPressed: null,
                          child: Row(
                            children: [
                              Icon(
                                size: 20,
                                CupertinoIcons.add_circled,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text('Add',
                                  style: normalTextStyle.copyWith(
                                    fontSize: 14,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                  ))
                            ],
                          ));
                    }

                    return TextButton(
                        onPressed: () {
                          int amountInt = (snapshot.data['amount'] as double)
                              .toInt(); // Safely convert double to int
                          _showAddTransaction(context, user.uid, amountInt);
                        },
                        child: Row(
                          children: [
                            Icon(
                              size: 20,
                              CupertinoIcons.add_circled,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text('Add',
                                style: normalTextStyle.copyWith(
                                  fontSize: 14,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ))
                          ],
                        ));
                  },
                ),
              ],
            ),
            StreamBuilder(
                stream: PlansStreams()
                    .getTransactionsForPlan(user.uid, widget.plan.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text('Loading Transactions...'),
                    );
                  }
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No transactions yet'),
                    );
                  }
                  List<TransactionModel> data = snapshot.data!;
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: TransactionCard(
                            transaction: data[index],
                          ),
                        );
                      });
                })
          ],
        ));
  }
}
