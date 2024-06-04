import 'package:flutter/material.dart';
import 'package:my_cashflow/services/authentication/authentication.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ElevatedButton(
            onPressed: () {
              Authentication().signOut();
            },
            child: const Text('Sign Out'))
      ],
    );
  }
}
