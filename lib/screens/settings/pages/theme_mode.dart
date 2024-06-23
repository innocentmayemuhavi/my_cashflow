import 'package:flutter/material.dart';
import 'package:my_cashflow/providers/theme_provider.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:provider/provider.dart';

class ThemeModeSetting extends StatefulWidget {
  const ThemeModeSetting({super.key});

  @override
  State<ThemeModeSetting> createState() => _ThemeModeSettingState();
}

class _ThemeModeSettingState extends State<ThemeModeSetting> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );

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
          title: Text('App Appearence ', style: appbarTitleStyle),
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
                  themeProvider.toggleTheme();
                },
                child: ListTile(
                  title: Text(
                    'Dark Theme',
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
                      value: themeProvider.themeMode == ThemeMode.dark
                          ? true
                          : false, // You need a boolean variable to manage the Switch state
                      onChanged: (bool value) {
                        themeProvider.toggleTheme();
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
