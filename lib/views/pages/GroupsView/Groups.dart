import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/views/pages/GroupsView/Discover.dart';
import 'package:iti_community_flutter/views/pages/GroupsView/Requested.dart';
import 'package:iti_community_flutter/views/pages/GroupsView/YourGroups.dart';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStatelessWidget(),
    );
  }
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'YourGroups'),
  Tab(text: 'Requested'),
  Tab(text: 'Discover'),
];

class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: HexColor("801818"),
              bottom: const TabBar(
                tabs: tabs,
              ),
            ),
          ),
          body: TabBarView(
            children:
                ([YourGroups(), RequestedGroups(), DiscoverGroups()]).toList(),
          ),
        );
      }),
    );
  }
}
