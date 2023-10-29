import 'package:flutter/material.dart';
import 'package:vair_app/app/widget/screen/account_screen.dart';
import 'package:vair_app/app/widget/screen/home_screen.dart';
import 'package:vair_app/app/widget/screen/library_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static const _logoAsset = 'img/vair_logo.png';
  int selectedIndex = 0;

  static const List<Widget> tabs = <Widget>[
    HomeScreen(),
    LibraryScreen(),
    AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildRow({
    required String title,
    required String description,
    required String amount,
    TextStyle? style,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        Expanded(
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        Expanded(
          child: Text(
            amount,
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          selectedIndex: selectedIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.library_books),
              icon: Icon(Icons.library_books_outlined),
              label: 'Library',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.people),
              icon: Icon(Icons.people_outlined),
              label: 'Account',
            ),
          ],
        ),
        appBar: AppBar(
          title: SizedBox(
            height: 32,
            child: Image.asset(
              _logoAsset,
              fit: BoxFit.contain,
              height: 32,
            ),
          ),
        ),
        body: tabs.elementAt(selectedIndex));
  }
}
