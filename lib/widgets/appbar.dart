import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  AppBarWidget(
      {super.key,
      required this.title,
      required this.hasLeading,
      required this.isTitleCentered,
      required this.actions,
      required this.hasAction,
      required this.previousIndex,
      required this.onItemTapped});

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
  final Widget title;
  final bool hasLeading;
  final bool isTitleCentered;
  final List<Widget> actions;
  final bool hasAction;
  final int previousIndex;
  Function onItemTapped;

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 100,
      centerTitle: widget.isTitleCentered,
      scrolledUnderElevation: 0,
      elevation: 0,
      leading: widget.hasLeading
          ? IconButton(
              onPressed: () {
                widget.onItemTapped(widget.previousIndex);
              },
              icon: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                    ),
                  )
                ],
              ))
          : null,
      title: widget.title,
      actions: widget.hasAction ? widget.actions : null,
    );
  }
}
