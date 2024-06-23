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
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
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
                    Transform.scale(
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
                        value: themeProvider.themeMode == ThemeMode.dark
                            ? true
                            : false, // You need a boolean variable to manage the Switch state
                        onChanged: (bool value) {
                          themeProvider.toggleTheme();
                        },
                      ),
                    ),
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
