import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_cashflow/cards/transactioncard.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/services/firestore/streams/walletstream.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:provider/provider.dart';

class MyExpences extends StatefulWidget {
  const MyExpences({super.key});

  @override
  State<MyExpences> createState() => _MyExpencesState();
}

class _MyExpencesState extends State<MyExpences> {
  @override
  @override
  Widget build(BuildContext context) {
    User_Class user = Provider.of<User_Class>(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          leadingWidth: 100,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 17,
                ),
                Text('Back')
              ],
            ),
          ),
          title: Text(
            'My Expenses',
            style: appbarTitleStyle,
          ),
        ),
        body: StreamBuilder(
            stream: Walletstream().getExpences(user.uid),
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
                    Text('Loading your expences ..', style: normalTextStyle),
                  ],
                ));
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error occurred'),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('No Expences yet'),
                );
              }
              return Scrollbar(
                interactive: true,
                notificationPredicate: (notification) =>
                    notification.depth == 0,
                thickness:
                    6.0, // Optional: Adjust the thickness of the scrollbar
                radius: const Radius.circular(
                    10), // Optional: Adjust the radius of the scrollbar's corners
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Transform.flip(
                      child:
                          TransactionCard(transaction: snapshot.data![index]),
                    );
                  },
                ),
              );
            }));
  }
}
