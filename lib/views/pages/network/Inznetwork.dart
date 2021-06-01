import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:iti_community_flutter/views/pages/network/Requseted.dart';
import 'package:iti_community_flutter/views/pages/network/MyRequest.dart';
import 'package:iti_community_flutter/views/pages/network/yourConnects.dart';

class InzNetwork extends StatefulWidget {
  @override
  _InzNetworkState createState() => _InzNetworkState();
}

class _InzNetworkState extends State<InzNetwork> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NetworkStatelessWidget(),
    );
  }
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'Connects'),
  Tab(text: 'Requests'),
  Tab(text: 'MyRquest'),
];

class NetworkStatelessWidget extends StatelessWidget {
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
            children: ([yourConnects(), connectRequest(), myRquest()]).toList(),
          ),
        );
      }),
    );
  }
}
