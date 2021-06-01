import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/views/pages/jobs/RecommendedJobs.dart';
import 'package:iti_community_flutter/views/pages/jobs/appliedJobs.dart';
import 'package:iti_community_flutter/views/pages/jobs/savedJobs.dart';

class InzJobs extends StatefulWidget {
  @override
  _InzJobsState createState() => _InzJobsState();
}

class _InzJobsState extends State<InzJobs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JobsStatelessWidget(),
    );
  }
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'Recommended'),
  Tab(text: 'Applied'),
  Tab(text: 'Saved'),
];

class JobsStatelessWidget extends StatelessWidget {
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
                ([RecommendedJobs(), appliedJobs(), savedJobs()]).toList(),
          ),
        );
      }),
    );
  }
}
