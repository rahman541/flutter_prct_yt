import 'package:flutter/material.dart';
import 'package:flutter_prct_yt/CalendarScreen.dart';
import 'package:flutter_prct_yt/ContactsScreen.dart';
import 'package:flutter_prct_yt/InboxScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        body: [
          InboxScreen(),
          ContactsScreen(),
          CalendarScreen(),
        ].elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(title: Text('Inbox'), icon: Icon(FontAwesomeIcons.envelope)),
            BottomNavigationBarItem(title: Text('People'), icon: Icon(FontAwesomeIcons.idCard)),
            BottomNavigationBarItem(title: Text('Calendar'), icon: Icon(FontAwesomeIcons.calendarAlt)),
          ],
          onTap: _onBarItemTap,
          currentIndex: _selectedIndex,
        ),
      ),
      length: 2,
    );
  }

  void _onBarItemTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}