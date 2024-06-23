import 'package:flutter/material.dart';
import 'package:my_cashflow/shared/styles.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          centerTitle: true,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
                Text(
                  'Back',
                  style: normalTextStyle,
                )
              ],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          title: Text('Notifications ', style: appbarTitleStyle),
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]!.withOpacity(.4)
                    : Colors.grey[100],

                borderRadius: BorderRadius.circular(
                    15.0), // Optional: if you want rounded corners
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _switchValue = !_switchValue;
                  });
                },
                child: ListTile(
                  title: Text(
                    'Push Notifications',
                    style: normalTextStyle.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black),
                  ),
                  trailing: Transform.scale(
                    scale: 0.8, // Adjust the scale factor to suit your needs
                    child: Switch(
                      inactiveTrackColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.grey,
                      inactiveThumbColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[100]
                              : Colors.grey[400],
                      activeColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                      value:
                          _switchValue, // You need a boolean variable to manage the Switch state
                      onChanged: (bool value) {
                        setState(() {
                          _switchValue = value; // Update the switch state
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
