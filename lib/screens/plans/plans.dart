import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/plans_model.dart';
import 'package:my_cashflow/models/transaction_model.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/screens/cards/plancard.dart';
import 'package:my_cashflow/screens/createplan/createplan.dart';
import 'package:my_cashflow/services/firestore/streams/plans_streams.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:provider/provider.dart';

class Plans extends StatefulWidget {
  const Plans({super.key});

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  final List<String> _plans = ['Plan 1', 'Plan 2', 'Plan 3'];
  @override
  Widget build(BuildContext context) {
    User_Class user = Provider.of<User_Class>(context);

    return StreamBuilder(
      stream: PlansStreams().getPlans(user.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Loading Plans...'));
        }
        print(snapshot.data);

        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sorry, you have no plans yet',
                    style: normalTextStyle.copyWith(fontSize: 20)),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const CreatePlan()),
                    );
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 40,
                  ),
                )
              ],
            ),
          );
        }
        // List<PlansModel> data = snapshot.data! as List<PlansModel>;
        List<PlansModel> data = snapshot.data!.map<PlansModel>((dynamic item) {
          return PlansModel(
            id: item['id'],
            amount: (item['amount'] as num).toInt(),
            spent: (item['spent'] as num).toInt(),
            planName: item['planName'] ?? '',
            category: item['category'] ?? '',
            color: item['color'] ?? '',
            description: item['description'] ?? '',
            endDate:
                (item['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
            startDate:
                (item['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
            transactions: (item['transactions'] as List<dynamic> ?? <dynamic>[])
                .map<TransactionModel>((dynamic transactionItem) {
              return TransactionModel(
                  amount: transactionItem['amount'],
                  timestamp: transactionItem['timestamp'],
                  category: transactionItem['category']);
            }).toList(),
          ); // Assuming PlansModel has a fromMap constructor
        }).toList();

        // return Container();

        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Plancard(plan: data[index]);
            });
      },
    );
  }
}
