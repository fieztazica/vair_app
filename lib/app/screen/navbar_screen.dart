import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:vair_app/app/screen/account_screen.dart';
import 'package:vair_app/app/screen/home_screen.dart';
import 'package:vair_app/app/screen/library_screen.dart';
import 'package:vair_app/app/screen/notification_screen.dart';
import 'package:vair_app/app/screen/search_screen.dart';
import 'package:vair_app/app/screen/signin_screen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  static const _logoAsset = 'assets/img/vair_logo.png';
  int selectedIndex = 0;
  late AuthUser _authUser;
  bool isSignedIn = false;

  static const List<Widget> tabs = <Widget>[
    HomeScreen(),
    LibraryScreen(),
    AccountScreen(),
  ];

  onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    setState(() {
      _authUser = user;
    });
    return user;
  }

  Future<bool> isUserSignedIn() async {
    final result = await Amplify.Auth.fetchAuthSession();
    setState(() {
      isSignedIn = result.isSignedIn;
    });
    return result.isSignedIn;
  }

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
          onDestinationSelected: onTabTapped,
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
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 24,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications,
                size: 24,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationScreen()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 24,
                ),
                onPressed: () {
                  if (isSignedIn) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SigninScreen()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AccountScreen()));
                  }
                },
              ),
            )
          ],
        ),
        body: tabs.elementAt(selectedIndex));
  }
}
