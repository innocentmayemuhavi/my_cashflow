import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  late SharedPreferences _prefs;

  ThemeProvider() {
    _initializePrefs();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final isDarkTheme = _prefs.getBool('isDark');
    _themeMode = isDarkTheme != null
        ? (isDarkTheme ? ThemeMode.dark : ThemeMode.light)
        : ThemeMode.system;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _prefs.setBool('isDark', _themeMode == ThemeMode.dark);
    notifyListeners();
  }
}
