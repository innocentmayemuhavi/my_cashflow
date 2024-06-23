import 'package:flutter/material.dart';
import 'package:my_cashflow/providers/theme_provider.dart';
import 'package:my_cashflow/services/authentication/authentication.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    // Initialize SharedPreferences on initState
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });
  }
  //  Future<void> _incrementCounter() async {
  //   final SharedPreferences prefs = await _prefs;
  //   final int counter = (prefs.getInt('counter') ?? 0) + 1;

  //   setState(() {
  //     _counter = prefs.setInt('counter', counter).then((bool success) {
  //       return counter;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).textTheme.bodySmall!.color!,
                    width: .5),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account Settings',
                    style: normalTextStyle.copyWith(fontSize: 20)),
                Text('Update your account details here',
                    style: normalTextStyle.copyWith(fontSize: 15))
              ],
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).textTheme.bodySmall!.color!,
                    width: .5),
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('App Appearance',
                        style: normalTextStyle.copyWith(fontSize: 20)),
                    Text('Update your app appearance here',
                        style: normalTextStyle.copyWith(fontSize: 15))
                  ],
                ),
                Column(
                  children: [
                    Text('Dark Mode',
                        style: normalTextStyle.copyWith(fontSize: 15)),
                    Switch(
                        trackColor: WidgetStateProperty.all(
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[800]
                                : Colors.grey[400]),
                        thumbColor: WidgetStateProperty.all(Colors.grey[200]),
                        value: _prefs?.getBool('isDark') ?? false,
                        onChanged: (value) {
                          themeProvider.toggleTheme();
                          // ThemeProvider().toggleTheme();
                        })
                  ],
                )
              ],
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).textTheme.bodySmall!.color!,
                    width: .5),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account Settings',
                    style: normalTextStyle.copyWith(fontSize: 20)),
                Text('Update your account details here',
                    style: normalTextStyle.copyWith(fontSize: 15))
              ],
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).textTheme.bodySmall!.color!,
                    width: .5),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account Settings',
                    style: normalTextStyle.copyWith(fontSize: 20)),
                Text('Update your account details here',
                    style: normalTextStyle.copyWith(fontSize: 15))
              ],
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).textTheme.bodySmall!.color!,
                    width: .5),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account Settings',
                    style: normalTextStyle.copyWith(fontSize: 20)),
                Text('Update your account details here',
                    style: normalTextStyle.copyWith(fontSize: 15))
              ],
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).textTheme.bodySmall!.color!,
                    width: .5),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account Settings',
                    style: normalTextStyle.copyWith(fontSize: 20)),
                Text('Update your account details here',
                    style: normalTextStyle.copyWith(fontSize: 15))
              ],
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).textTheme.bodySmall!.color!,
                    width: .5),
                borderRadius: BorderRadius.circular(7)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Account Settings',
                    style: normalTextStyle.copyWith(fontSize: 20)),
                Text('Update your account details here',
                    style: normalTextStyle.copyWith(fontSize: 15))
              ],
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.red, width: 1)),
            onPressed: () {
              Authentication().signOut();
            },
            child: Text(
              'Sign Out',
              style: normalTextStyle.copyWith(color: Colors.red),
            ))
      ],
    );
  }
}
