import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/providers/theme_provider.dart';
import 'package:my_cashflow/screens/settings/pages/notifications.dart';
import 'package:my_cashflow/screens/settings/pages/theme_mode.dart';
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
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.all(12),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]!.withOpacity(.4)
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
              title: Text('Account',
                  style: normalTextStyle.copyWith(
                      color: Theme.of(context).textTheme.bodySmall!.color)),
              subtitle: Text(
                'Privacy, security, change password',
                style: normalTextStyle.copyWith(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodySmall!.color),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const NotificationSetting(),
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]!.withOpacity(.4)
                : Colors.grey[100],

            borderRadius: BorderRadius.circular(
                15.0), // Optional: if you want rounded corners
          ),
          child: ListTile(
              title: Text(
                'Notifications',
                style: normalTextStyle.copyWith(
                    color: Theme.of(context).textTheme.bodySmall!.color),
              ),
              subtitle: Text(
                'Push notifications, message and call tones',
                style: normalTextStyle.copyWith(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodySmall!.color),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const NotificationSetting(),
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]!.withOpacity(.4)
                : Colors.grey[100],

            borderRadius: BorderRadius.circular(
                15.0), // Optional: if you want rounded corners
          ),
          child: ListTile(
              title: Text(
                'App Appearance',
                style: normalTextStyle.copyWith(
                    color: Theme.of(context).textTheme.bodySmall!.color),
              ),
              subtitle: Text(
                'App theme',
                style: normalTextStyle.copyWith(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodySmall!.color),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const ThemeModeSetting(),
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]!.withOpacity(.4)
                : Colors.grey[100],

            borderRadius: BorderRadius.circular(
                15.0), // Optional: if you want rounded corners
          ),
          child: ListTile(
              title: Text('Data and storage usage',
                  style: normalTextStyle.copyWith(
                      color: Theme.of(context).textTheme.bodySmall!.color)),
              subtitle: Text('Network usage, auto-download,auto-play',
                  style: normalTextStyle.copyWith(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const NotificationSetting(),
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]!.withOpacity(.4)
                : Colors.grey[100],

            borderRadius: BorderRadius.circular(
                15.0), // Optional: if you want rounded corners
          ),
          child: ListTile(
              title: Text('Permissions',
                  style: normalTextStyle.copyWith(
                      color: Theme.of(context).textTheme.bodySmall!.color)),
              subtitle: Text('Camera, microphone, contacts',
                  style: normalTextStyle.copyWith(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const NotificationSetting(),
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]!.withOpacity(.4)
                : Colors.grey[100],

            borderRadius: BorderRadius.circular(
                15.0), // Optional: if you want rounded corners
          ),
          child: ListTile(
              title: Text('Frequently asked questions',
                  style: normalTextStyle.copyWith(
                      color: Theme.of(context).textTheme.bodySmall!.color)),
              subtitle: Text('FAQs, contact us, privacy policy',
                  style: normalTextStyle.copyWith(
                    fontSize: 13,
                    color: Theme.of(context).textTheme.bodySmall!.color,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const NotificationSetting(),
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios, size: 15)),
        ),
        const SizedBox(
          height: 70,
        ),
        // ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //         side: const BorderSide(color: Colors.red, width: 1)),
        //     onPressed: () {
        //       Authentication().signOut();
        //     },
        //     child: Text(
        //       'Sign Out',
        //       style: normalTextStyle.copyWith(color: Colors.red),
        //     ))
      ],
    ));
  }
}
