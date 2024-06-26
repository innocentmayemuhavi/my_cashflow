import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cashflow/models/user_model.dart';
import 'package:my_cashflow/screens/createplan/createplan.dart';
import 'package:my_cashflow/screens/homepage/home.dart';
import 'package:my_cashflow/screens/plans/plans.dart';
import 'package:my_cashflow/screens/savings/savings.dart';
import 'package:my_cashflow/screens/settings/settings.dart';
import 'package:my_cashflow/screens/wallet/wallet.dart';
import 'package:my_cashflow/services/authentication/authentication.dart';
import 'package:my_cashflow/shared/styles.dart';
import 'package:my_cashflow/widgets/appbar.dart';
import 'package:my_cashflow/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  int _currentIndex = 0;
  int _previousIndex = 0;
  bool _isLoading = false;
  final List<Widget> _screens = [
    const HomePage(),
    const Wallet(),
    const Plans(),
    const Settings()
  ];
  final List<String> _titles = ['Wallet', 'My plans', 'Settings'];

  void _onItemTapped(int index) {
    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User_Class user = Provider.of<User_Class>(context);
    return Scaffold(
      appBar: AppBarWidget(
        previousIndex: _previousIndex,
        onItemTapped: _onItemTapped,
        isTitleCentered: _currentIndex == 0 ? false : true,
        hasLeading: _currentIndex == 0 ? false : true,
        hasAction:
            _currentIndex == 1 || _currentIndex == 2 || _currentIndex == 3,
        actions: [
          _currentIndex == 2
              ? TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const CreatePlan()));
                  },
                  child: Text('Add Plan',
                      style: normalTextStyle.copyWith(
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      )),
                )
              : _currentIndex == 3
                  ? TextButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              setState(() {
                                _isLoading = true;
                              });
                              Authentication()
                                  .signOut()
                                  .then((_) => setState(() {
                                        _isLoading = false;
                                      }))
                                  .catchError((error) {
                                setState(() {
                                  _isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error.toString()),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              });
                            },
                      child: Text(
                        _isLoading ? 'Loging out...' : 'Logout',
                        style: normalTextStyle.copyWith(color: Colors.red),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const SavingsPage()));
                      },
                      child: Text(
                        'Savings',
                        style: normalTextStyle.copyWith(
                            color:
                                Theme.of(context).textTheme.bodySmall!.color),
                      ),
                    )
        ],
        title: _currentIndex == 0
            ? Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello, ${user.displayName ?? 'There'}',
                        style: normalTextStyle.copyWith(fontSize: 30)),
                    Text(
                      'Your Cashflow',
                      style: normalTextStyle.copyWith(
                        fontSize: 15.0,
                        color: Colors.grey[400],
                      ),
                    )
                  ],
                ),
              ])
            : Text(_titles[_currentIndex - 1], style: appbarTitleStyle),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomAppBarWidget(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
