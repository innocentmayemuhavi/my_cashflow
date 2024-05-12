import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatefulWidget {
  BottomAppBarWidget(
      {super.key, required this.onItemTapped, required this.currentIndex});

  Function onItemTapped;
  final int currentIndex;

  @override
  State<BottomAppBarWidget> createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        height: 60,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.timelapse),
            selectedIcon: Icon(CupertinoIcons.timelapse),
            label: 'My plans',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedIndex: widget.currentIndex,
        onDestinationSelected: (index) {
          widget.onItemTapped(index);
        });
  }
}
