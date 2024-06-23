import 'package:flutter/material.dart';
import 'package:emailjs/emailjs.dart';
import 'package:my_cashflow/services/authentication/authentication.dart';
import 'package:my_cashflow/shared/constans.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:my_cashflow/utils/error_formarter.dart';
import 'package:my_cashflow/utils/random_code_gen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key, required this.toggleLogin});
  final Function toggleLogin;

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  String _code = "";
  bool _isLoading = false;

  bool _onEditing = true;
  final bool _isCodeSent = false;
  final String _sentCode = generateRandomString();
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _name;
  int _currentIndex = 0;
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      physics: _currentIndex == 0
          ? _email != null && _password != null && _confirmPassword != null
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics()
          : _currentIndex == 1
              ? _name != null
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics()
              : _code == _sentCode
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      controller: _pageController,
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
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      Text('Welcomes You!',
                          style: normalTextStyle.copyWith(
                              fontSize: 50, fontWeight: FontWeight.w600)),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _email = value;
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
                                    : Colors.black,
                                width: 2.0),
                          ),
                          labelText: 'Email',
                          hintText: 'Enter your email',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _password = value;
                        },
                        obscureText: true,
                        obscuringCharacter: '*',
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
                                    : Colors.black,
                                width: 2.0),
                          ),
                          labelText: 'Password',
                          hintText: 'Enter your password',
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _confirmPassword = value;
                        },
                        obscureText: true,
                        obscuringCharacter: '*',
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
                                    : Colors.black,
                                width: 2.0),
                          ),
                          labelText: 'Confirm Password',
                          hintText: 'Enter your password',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  if (_password!.length < 6) {
                                    setState(() {
                                      _error =
                                          'Password must be at least 6 characters';
                                    });
                                  } else {
                                    if (_password != _confirmPassword) {
                                      setState(() {
                                        _error = 'Passwords do not match';
                                      });
                                    } else {
                                      setState(() {
                                        _error = '';
                                      });
                                      _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn);
                                    }
                                  }
                                }
                              },
                        child: Text('Sign Up',
                            style: normalTextStyle.copyWith(
                              fontSize: 20,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            )),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              widget.toggleLogin();
                            },
                            child: Text(
                              'Login',
                              style: normalTextStyle.copyWith(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Column(
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
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Form(
                key: _formKey1,
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Text('Tell Us More!',
                        style: normalTextStyle.copyWith(
                            fontSize: 50, fontWeight: FontWeight.w600)),
                    Text(
                      'Please tell us your name.',
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
                        _name = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      cursorColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                      decoration: InputDecoration(
                        labelStyle: normalTextStyle.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                              width: 2.0),
                        ),
                        labelText: 'Name',
                        hintText: 'Enter your Name',
                      ),
                    ),
                    const SizedBox(height: 100),
                    ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_formKey1.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  try {
                                    var result = await EmailJS.send(
                                      SERVICE_ID,
                                      TEMPLETE_ID,
                                      {
                                        'to_name': _name,
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
                                    print(result);
                                  } catch (error) {
                                    if (error is EmailJSResponseStatus) {
                                      print(
                                          'ERROR... ${error.status}: ${error.text}');
                                      setState(() {
                                        _isLoading = false;
                                        _error =
                                            'An error occured, please try again';
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
                        child: Text(_isLoading ? 'Sending code...' : 'Next',
                            style: normalTextStyle.copyWith(
                              fontSize: 20,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ))),
                    const SizedBox(height: 120),
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
                              Text('Back',
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
              ),
            ))
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
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Theme.of(context).colorScheme.secondary,
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
                    underlineUnfocusedColor: _code == _sentCode
                        ? Colors.green
                        : Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
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
                                    .registerWithEmailAndPass(
                                        _email!, _password!, _name!)
                                    .then((result) => {
                                          if (result is String)
                                            {
                                              setState(() {
                                                _isLoading = false;
                                                _error =
                                                    formatFirebaseError(result);
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
                            Text('Back',
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
