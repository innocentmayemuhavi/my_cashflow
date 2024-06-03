import 'package:flutter/material.dart';
import 'package:my_cashflow/shared/styles.dart';

class Deleteplan extends StatefulWidget {
  const Deleteplan({super.key});

  @override
  State<Deleteplan> createState() => _DeleteplanState();
}

class _DeleteplanState extends State<Deleteplan> {
  @override
  Widget build(BuildContext context) {
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
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes',
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
