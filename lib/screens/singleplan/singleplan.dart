import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/screens/cards/transactioncard.dart';
import 'package:my_cashflow/screens/modals/add_deposit.dart';
import 'package:my_cashflow/screens/modals/addplanbudget.dart';
import 'package:my_cashflow/screens/modals/deleteplan.dart';
import 'package:my_cashflow/shared/styles.dart';

class ViewPlan extends StatefulWidget {
  const ViewPlan({super.key});

  @override
  State<ViewPlan> createState() => _ViewPlanState();
}

class _ViewPlanState extends State<ViewPlan> {
  void _showAddTransaction(BuildContext context) {
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
          return const AddPlanTransaction();
        });
  }

  void _showDeposit(BuildContext context) {
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
          return const PlanDeposit();
        });
  }

  void _showDelete(BuildContext context) {
    showModalBottomSheet(
        context: context,
        showDragHandle: true,
        builder: (context) {
          return const Deleteplan();
        });
  }

  @override
  Widget build(BuildContext context) {
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
                        CupertinoIcons.car_detailed,
                        size: 50,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '#Transport',
                      style: boldTextStyle.copyWith(color: Colors.blue),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      'Trip to Kapsabet',
                      style: boldTextStyle.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Created at 12/12/2021',
                      style: normalTextStyle.copyWith(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'End  at 12/12/2021',
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
                        Text(
                          'Ksh 5000',
                          style: boldTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              _showDeposit(context);
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
                            )),
                      ],
                    ),
                    LinearProgressIndicator(
                      color: Colors.red,
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                      value:
                          .6, // Update this value (0.0 to 1.0) to reflect the current progress
                      backgroundColor: Colors.grey[200],
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ksh.2500',
                            style: normalTextStyle.copyWith(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '50%',
                            style: normalTextStyle.copyWith(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ]),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tansactions'),
                TextButton(
                    onPressed: () {
                      _showAddTransaction(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          size: 20,
                          CupertinoIcons.add_circled,
                          color: Theme.of(context).brightness == Brightness.dark
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
                    )),
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const TransactionCard();
                })
          ],
        ));
  }
}
