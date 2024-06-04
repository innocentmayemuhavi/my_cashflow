import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:my_cashflow/screens/auth/auth.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/widgets/home_main.dart';
import 'package:provider/provider.dart';

class Appstate extends StatefulWidget {
  const Appstate({super.key});

  @override
  State<Appstate> createState() => _AppstateState();
}

class _AppstateState extends State<Appstate> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<User_Class?>(context);
    print(data?.emailVerified);

    FirebaseAuth.instance.currentUser?.reload();
    return data != null ? const HomeMain() : const AuthenticationPage();
  }
}
