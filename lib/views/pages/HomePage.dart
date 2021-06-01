import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/app_localizations.dart';
import 'package:iti_community_flutter/services/auth/Authentication.dart';
import 'package:iti_community_flutter/views/pages/GroupsView/Groups.dart';
import 'package:iti_community_flutter/views/pages/Settings/Settings.dart';
import 'package:iti_community_flutter/views/pages/home/appHome.dart';
import 'package:iti_community_flutter/views/pages/jobs/InzJobs.dart';
import 'package:iti_community_flutter/views/pages/network/Inznetwork.dart';
import 'package:provider/provider.dart';

import 'home/inzHome.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    InzHome(),
    Groups(),
    InzNetwork(),
    InzJobs(),
    settings()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthServices>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('BottomNavigationBar Sample'),
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: HexColor("801818"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: AppLocalizations.of(context).translate('Groups'),
            backgroundColor: HexColor("801818"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.connect_without_contact),
            label: 'Network',
            backgroundColor: HexColor("801818"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
            backgroundColor: HexColor("801818"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: HexColor("801818"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
