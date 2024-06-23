import 'package:flutter/material.dart';
import 'package:my_cashflow/providers/theme_provider.dart';
import 'package:my_cashflow/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding().ensureSemantics();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const AppRoutes(),
    );
  }
}
