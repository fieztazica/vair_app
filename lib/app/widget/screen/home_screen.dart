import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  static const List<Widget> tabs = <Widget>[
    Center(
      child: Text("home"),
    ),
    Center(
      child: Text("library"),
    ),
    Center(
      child: Text("account"),
    ),
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
          indicatorColor: Colors.amber[800],
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
          title: const Text('Vair'),
        ),
        body: tabs.elementAt(selectedIndex));
  }
}
