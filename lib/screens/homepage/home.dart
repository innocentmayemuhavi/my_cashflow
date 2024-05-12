import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

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
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                'My budget',
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
                      onPressed: () {},
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
                      onPressed: () {},
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
        ),
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
                      Column(
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
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50), // Adjust this value as needed
                              side: const BorderSide(
                                  color: Colors
                                      .grey), // Adjust this value as needed
                            ),
                          ),
                        ),
                        onPressed: () {},
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
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  50), // Adjust this value as needed
                              side: const BorderSide(
                                  color: Colors
                                      .grey), // Adjust this value as needed
                            ),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.arrow_up_right,
                          size: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Plan',
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
        SizedBox(
          height: 150, // Set a specific height
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 100,
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#Construction',
                        style: normalTextStyle.copyWith(
                            color: Colors.blue, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'House Building',
                        style: normalTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ksh 5,000',
                            style: boldTextStyle.copyWith(fontSize: 15),
                          ),
                          Text(
                            'Ksh 10,000',
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
                        value:
                            .6, // Update this value (0.0 to 1.0) to reflect the current progress
                        backgroundColor: Colors.grey[200],
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ],
                  ));
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
            return Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shopping',
                            style: normalTextStyle.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Ksh 5,000',
                            style: boldTextStyle.copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Dec 12th 2024',
                        style: normalTextStyle.copyWith(
                            fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        '12:00 PM',
                        style: normalTextStyle.copyWith(
                            fontSize: 15, color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
