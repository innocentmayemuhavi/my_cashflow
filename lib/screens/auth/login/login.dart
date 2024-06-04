import 'package:emailjs/emailjs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:my_cashflow/services/authentication/authentication.dart';
import 'package:my_cashflow/shared/constans.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/utils/error_formarter.dart';
import 'package:my_cashflow/utils/random_code_gen.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.toggleLogin});
  final Function toggleLogin;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  final String _sentCode = generateRandomString();
  String? _email;
  String _code = '';
  String? _password;
  String? _confirmPassword;
  String? _name;
  final int _currentIndex = 0;
  String _error = '';
  bool _onEditing = true;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      padEnds: true,
      children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(vertical: 50),
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('assets/images/logo.png', height: 100)),
            Text('Cash Flow',
                style: normalTextStyle.copyWith(
                    fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.blue,
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      Text('Welcome Back!',
                          style: normalTextStyle.copyWith(
                              fontSize: 50, fontWeight: FontWeight.w600)),
                      Text(
                        'Sign in to your account.',
                        style: normalTextStyle,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _error,
                        textAlign: TextAlign.center,
                        style: normalTextStyle.copyWith(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        cursorColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        decoration: InputDecoration(
                          labelStyle: normalTextStyle.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        decoration: InputDecoration(
                          labelStyle: normalTextStyle.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          labelText: 'Password',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                // if (_formKey.currentState!.validate()) {

                                //   // ScaffoldMessenger.of(context).showSnackBar(
                                //   //     const SnackBar(
                                //   //         content: Text('Processing Data')));

                                //   // Authentication().signInWithEmailAndPass();
                                // }

                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    var result = await EmailJS.send(
                                      SERVICE_ID,
                                      TEMPLETE_ID,
                                      {
                                        'to_name': 'There...',
                                        'from_name': 'Cash Flow Admin',
                                        'code': _sentCode,
                                        'email': _email,
                                      },
                                      Options(
                                          publicKey: PUBLIC_ID,
                                          privateKey: PRIVATE_KEY),
                                    );

                                    setState(() {
                                      _isLoading = false;
                                    });
                                    _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  } catch (error) {
                                    if (error is EmailJSResponseStatus) {
                                      print(
                                          'ERROR... ${error.status}: ${error.text}');
                                      setState(() {
                                        _isLoading = false;
                                        _error =
                                            formatFirebaseError(error.text);
                                      });
                                    } else {
                                      setState(() {
                                        _isLoading = false;
                                        _error =
                                            'An error occured, please try again';
                                      });
                                    }
                                  }
                                }
                              },
                        child: Text(_isLoading ? 'Logging in' : 'Login',
                            style: normalTextStyle.copyWith(
                              fontSize: 20,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            )),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            onPressed: () {
                              widget.toggleLogin();
                            },
                            child: Text('Sign Up',
                                style: normalTextStyle.copyWith(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Container(
                padding: const EdgeInsets.only(top: 50, bottom: 50, left: 70),
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('assets/images/otp.png', height: 100)),
            Text('Cash Flow',
                style: normalTextStyle.copyWith(
                    fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.blue,
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text('Enter Code',
                      style: normalTextStyle.copyWith(
                          fontSize: 50, fontWeight: FontWeight.w600)),
                  Text(
                    'Please enter verification code sent in your email.',
                    style: normalTextStyle,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _error,
                    textAlign: TextAlign.center,
                    style: normalTextStyle.copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  VerificationCode(
                    digitsOnly: true,
                    fullBorder: true,
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      color: _code.length == 4 && _code != _sentCode
                          ? Colors.red
                          : Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                    ),
                    keyboardType: TextInputType.number,
                    underlineColor: _code == _sentCode
                        ? Colors.green
                        : Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors
                                .black, // If this is null it will use primaryColor: Colors.red from Theme
                    length: 4,
                    cursorColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors
                            .black, // If this is null it will default to the ambient
                    // clearAll is NOT required, you can delete it
                    // takes any widget, so you can implement your design
                    clearAll: const Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text(
                        'clear all',
                        style: TextStyle(
                          fontSize: 14.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    onCompleted: (String value) {
                      setState(() {
                        _code = value;
                      });
                    },
                    onEditing: (bool value) {
                      setState(() {
                        _onEditing = value;
                      });
                      if (!_onEditing) FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                      onPressed: _isLoading || _code != _sentCode
                          ? null
                          : () {
                              if (_code == _sentCode) {
                                setState(() {
                                  _isLoading = true;
                                });
                                Authentication()
                                    .signInWithEmailAndPass(_email!, _password!)
                                    .then((result) => {
                                          if (result is String)
                                            {
                                              setState(() {
                                                _error = result;
                                                _isLoading = false;
                                              })
                                            }

                                          // if (result != null)
                                          //   {

                                          //     _pageController.nextPage(
                                          //         duration: const Duration(
                                          //             milliseconds: 300),
                                          //         curve: Curves.easeIn)
                                          //   }
                                        })
                                    .catchError((error) {
                                  setState(() {
                                    _isLoading = false;
                                    _error = formatFirebaseError(error);
                                  });
                                });
                              }
                            },
                      child: Text(_isLoading ? 'Verifying' : 'Verify',
                          style: normalTextStyle.copyWith(
                            fontSize: 20,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ))),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            Text('Back to Login',
                                style: normalTextStyle.copyWith(
                                  fontSize: 18,
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      ],
    ));
  }
}
