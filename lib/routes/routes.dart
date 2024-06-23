import 'package:flutter/material.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/providers/theme_provider.dart';
import 'package:my_cashflow/screens/auth/auth.dart';
import 'package:my_cashflow/services/authentication/authentication.dart';
import 'package:my_cashflow/state/appstate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRoutes extends StatefulWidget {
  const AppRoutes({super.key});

  @override
  State<AppRoutes> createState() => _AppRoutesState();
}

class _AppRoutesState extends State<AppRoutes> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return StreamProvider(
      create: (context) => Authentication().user,
      initialData: null,
      child: Consumer<User_Class?>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          themeMode: themeProvider.themeMode, // Use system theme initially
          theme: ThemeData(
            scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor: WidgetStateProperty.all(Colors.grey[200]),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            colorScheme: const ColorScheme.light()
                .copyWith(brightness: Brightness.light),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor: WidgetStateProperty.all(Colors.grey[200]),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            colorScheme:
                const ColorScheme.dark().copyWith(brightness: Brightness.dark),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const Appstate(),
            '/auth': (context) => const AuthenticationPage(),
          },
        ),
      ),
    );
  }
}
