import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_cashflow/screens/auth/login/login.dart';
import 'package:my_cashflow/screens/auth/signup/signup.dart';
import 'package:my_cashflow/services/authentication/authentication.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/error_formarter.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  bool isLogin = false;

  void toggleLogin() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogin ? Login(toggleLogin: toggleLogin) : Signup( toggleLogin: toggleLogin);
  }
}
