import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/screens/cards/plancard.dart';
import 'package:my_cashflow/screens/cards/transactioncard.dart';
import 'package:my_cashflow/screens/expences/expences.dart';
import 'package:my_cashflow/screens/incomes/incomes.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/widgets/main_blc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                      Row(
                        children: [
                          const Icon(
                            Icons.trending_up,
                            color: Colors.green,
                            size: 17,
                          ),
                          Text(
                            '+3.23%',
                            style: normalTextStyle.copyWith(
                                color: Colors.green, fontSize: 15),
                          )
                        ],
                      )
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
                            Text(
                              'Ksh 10,000',
                              style: boldTextStyle.copyWith(
                                  fontSize: 25, fontWeight: FontWeight.normal),
                            )
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.trending_down,
                              color: Colors.green,
                              size: 17,
                            ),
                            Text(
                              '-1.23%',
                              style: normalTextStyle.copyWith(
                                  color: Colors.green, fontSize: 15),
                            )
                          ],
                        )
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
                            Text(
                              'Ksh 10,000',
                              style: boldTextStyle.copyWith(
                                  fontSize: 25, fontWeight: FontWeight.normal),
                            )
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
              return const Plancard();
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
        ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const TransactionCard();
          },
        ),
      ],
    );
  }
}
