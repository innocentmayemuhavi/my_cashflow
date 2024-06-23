import 'package:flutter/material.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/services/firestore/plans/plans.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:provider/provider.dart';

class Deleteplan extends StatefulWidget {
  const Deleteplan({super.key, required this.planId});
  final String planId;

  @override
  State<Deleteplan> createState() => _DeleteplanState();
}

class _DeleteplanState extends State<Deleteplan> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    User_Class user = Provider.of<User_Class>(context);
    return Container(
        padding: const EdgeInsets.all(20),
        height: 210,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Center(
                child: Icon(
              Icons.priority_high,
              size: 60,
            )),
            Text(
              'Are you sure you want to delete this plan?',
              style: normalTextStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * .4, 30),
                      side: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          width: 1)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: normalTextStyle.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * .4, 30),
                      side: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          width: 1)),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    PlansServices()
                        .deletePlan(user.uid, widget.planId)
                        .then((_) {
                      setState(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(context, '/');
                    }).catchError((error) {
                      print(error);
                    });
                  },
                  child: Text(_isLoading ? 'Deleting...' : 'Yes',
                      style: normalTextStyle.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      )),
                ),
              ],
            )
          ],
        ));
  }
}
