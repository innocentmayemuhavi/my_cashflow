import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/screens/cards/transactioncard.dart';
import 'package:my_cashflow/screens/expences/expences.dart';
import 'package:my_cashflow/screens/incomes/incomes.dart';
import 'package:my_cashflow/services/firestore/streams/walletstream.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/formart_curr.dart';
import 'package:my_cashflow/widgets/main_blc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User_Class user = Provider.of<User_Class>(context);
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(15),
      children: <Widget>[
        const MainBlc(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Budget overview',
              style: normalTextStyle.copyWith(fontSize: 17),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        CupertinoIcons.arrow_down_left_circle,
                      ),
                      Container(
                        width: 55,
                      ),
                      StreamBuilder(
                          stream: Walletstream().getIncome(user.uid),
                          builder: (context, snapshot) {
                            return Row(
                              children: [
                                Icon(
                                  snapshot.data != null
                                      ? snapshot.data!.percentage < 0
                                          ? snapshot.data!.percentage == 0
                                              ? Icons.remove
                                              : Icons.trending_down
                                          : Icons.trending_up
                                      : Icons.line_axis,
                                  color: snapshot.data != null
                                      ? snapshot.data!.percentage < 0
                                          ? Colors.red
                                          : snapshot.data!.percentage == 0
                                              ? Colors.grey
                                              : Colors.green
                                      : Colors.grey,
                                  size: 17,
                                ),
                                Text(
                                  snapshot.data != null
                                      ? '${snapshot.data!.percentage.toString()} %'
                                      : '0.0%',
                                  style: normalTextStyle.copyWith(
                                      color: snapshot.data != null
                                          ? snapshot.data!.percentage < 0
                                              ? Colors.red
                                              : snapshot.data!.percentage == 0
                                                  ? Colors.grey
                                                  : Colors.green
                                          : Colors.grey,
                                      fontSize: 15),
                                )
                              ],
                            );
                          })
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const IncomesPage()),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Incomes',
                                style: normalTextStyle.copyWith(
                                    fontSize: 20, color: Colors.grey)),
                            StreamBuilder(
                                stream: Walletstream().getIncome(user.uid),
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data != null
                                        ? 'Ksh ${formatNumber(snapshot.data!.total)}'
                                        : 'Ksh. 0.0',
                                    style: boldTextStyle.copyWith(
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal),
                                  );
                                })
                          ],
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50), // Adjust this value as needed
                              side: const BorderSide(
                                  color: Colors
                                      .grey), // Adjust this value as needed
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const IncomesPage()),
                          );
                        },
                        icon: const Icon(
                          CupertinoIcons.arrow_up_right,
                          size: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const MyExpences()),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          CupertinoIcons.arrow_up_right_circle,
                        ),
                        Container(
                          width: 55,
                        ),
                        StreamBuilder(
                            stream: Walletstream().getSpending(user.uid),
                            builder: (context, snapshot) {
                              return Row(
                                children: [
                                  Icon(
                                    snapshot.data != null
                                        ? snapshot.data!.percentage > 0
                                            ? Icons.trending_up
                                            : snapshot.data!.percentage == 0.0
                                                ? Icons.remove
                                                : Icons.trending_down
                                        : Icons.remove,
                                    color: snapshot.data != null
                                        ? snapshot.data!.percentage > 0
                                            ? Colors.red
                                            : snapshot.data!.percentage == 0
                                                ? Colors.grey
                                                : Colors.green
                                        : Colors.grey,
                                    size: 17,
                                  ),
                                  Text(
                                    snapshot.data != null
                                        ? '${snapshot.data!.percentage.toString()}%'
                                        : '0.0%',
                                    style: normalTextStyle.copyWith(
                                        color: snapshot.data != null
                                            ? snapshot.data!.percentage > 0
                                                ? Colors.red
                                                : snapshot.data!.percentage == 0
                                                    ? Colors.grey
                                                    : Colors.green
                                            : Colors.grey,
                                        fontSize: 15),
                                  )
                                ],
                              );
                            })
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Spending',
                                style: normalTextStyle.copyWith(
                                    fontSize: 20, color: Colors.grey)),
                            StreamBuilder(
                                stream: Walletstream().getSpending(user.uid),
                                builder: (context, snapshot) {
                                  // Check if snapshot.data is not null before accessing its total property

                                  return Text(
                                    snapshot.data != null
                                        ? 'Ksh ${formatNumber(snapshot.data!.total)}'
                                        : 'Ksh. 0.0',
                                    style: boldTextStyle.copyWith(
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal),
                                  );
                                })
                          ],
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    50), // Adjust this value as needed
                                side: const BorderSide(
                                    color: Colors
                                        .grey), // Adjust this value as needed
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const MyExpences()),
                            );
                          },
                          icon: const Icon(
                            CupertinoIcons.arrow_up_right,
                            size: 15,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Plans',
              style: normalTextStyle.copyWith(fontSize: 17),
            ),
            // Text(
            //   'See all',
            //   style: normalTextStyle.copyWith(
            //       fontSize: 13, color: Theme.of(context).colorScheme.secondary),
            // )
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150, // Set a specific height
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container();
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: normalTextStyle.copyWith(fontSize: 17),
            ),
            Text(
              'See all',
              style: normalTextStyle.copyWith(
                  fontSize: 13, color: Theme.of(context).colorScheme.secondary),
            )
          ],
        ),
        const SizedBox(height: 10),
        StreamBuilder(
          stream: Walletstream().getTransactions(user.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                padding: const EdgeInsets.all(100),
                child: Center(
                  child: Text(
                    'Loading Transactions ..',
                    style: normalTextStyle,
                  ),
                ),
              ); // return a loading indicator while waiting
            }

            if (snapshot.data != null && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return TransactionCard(transaction: snapshot.data![index]);
                },
              );
            }

            return Container(
              padding: const EdgeInsets.all(100),
              child: Center(
                child: Text(
                  'Sorry, No transactions yet!.',
                  style: normalTextStyle,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
