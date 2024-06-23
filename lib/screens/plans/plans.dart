import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_cashflow/models/plans_model.dart';
import 'package:my_cashflow/models/transaction_model.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/cards/plancard.dart';
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
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitFadingCircle(
                color: Theme.of(context).colorScheme.secondary,
                size: 50.0,
              ),
              Text('Loading Plans ..', style: normalTextStyle),
            ],
          ));
        }

        if (!snapshot.hasData) {
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
        if (snapshot.data!.isEmpty) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No plans yet!',
                style: normalTextStyle,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: Theme.of(context).textTheme.bodySmall!.color ??
                          Colors.black, // Added a fallback color
                      width: 1,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const CreatePlan()));
                  },
                  child: Text(
                    'Create Plan',
                    style: normalTextStyle.copyWith(
                        color: Theme.of(context).textTheme.bodySmall!.color),
                  ))
            ],
          ));
        }

        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Plancard(plan: snapshot.data![index]);
            });
      },
    );
  }
}
