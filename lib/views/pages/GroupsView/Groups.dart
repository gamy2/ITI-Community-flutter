import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iti_community_flutter/app_localizations.dart';
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
      supportedLocales: [Locale('en', 'UK'), Locale('ar', 'EG')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = <Tab>[
      // AppLocalizations.of(context).translate('Groups'),
      Tab(text: AppLocalizations.of(context).translate('YourGroups')),
      Tab(text: AppLocalizations.of(context).translate('Requested')),
      Tab(text: AppLocalizations.of(context).translate('Discover')),
    ];
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
              bottom: TabBar(
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
