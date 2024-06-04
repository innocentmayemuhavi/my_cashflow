import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/screens/auth/auth.dart';
import 'package:my_cashflow/services/authentication/authentication.dart';
import 'package:my_cashflow/state/appstate.dart';
import 'package:provider/provider.dart';

class AppRoutes extends StatefulWidget {
  const AppRoutes({super.key});

  @override
  State<AppRoutes> createState() => _AppRoutesState();
}

class _AppRoutesState extends State<AppRoutes> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
        create: (context) => Authentication().user,
        initialData: null,
        child: Consumer<User_Class?>(
            builder: (context, value, child) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  debugShowMaterialGrid: false,
                  darkTheme: ThemeData(
                    iconTheme: const IconThemeData(color: Colors.white),
                    colorScheme: const ColorScheme.dark()
                        .copyWith(brightness: Brightness.dark),
                  ),
                  themeAnimationCurve: Curves.easeInOutCubic,
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    iconTheme: const IconThemeData(
                        color: Colors.black), // Color for light themeed
                    colorScheme: const ColorScheme.light()
                        .copyWith(brightness: Brightness.light),

                    useMaterial3: true,
                  ),
                  themeMode: ThemeMode.system,
                  initialRoute: '/',
                  routes: {
                    '/': (context) => const Appstate(),
                    '/auth': (context) => const AuthenticationPage(),
                  },
                )));
  }
}
