import 'package:flutter/material.dart';
import 'package:my_cashflow/widgets/home_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      darkTheme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
        colorScheme:
            const ColorScheme.dark().copyWith(brightness: Brightness.dark),
      ),
      themeAnimationCurve: Curves.easeInOutCubic,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme:
            const IconThemeData(color: Colors.black), // Color for light themeed
        colorScheme:
            const ColorScheme.light().copyWith(brightness: Brightness.light),

        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const HomeMain(),
    );
  }
}
