import 'package:flutter/material.dart';
import 'package:flutter_pyday/agenda/cloud_screen.dart';
import 'package:flutter_pyday/agenda/mobile_screen.dart';
import 'package:flutter_pyday/agenda/web_screen.dart';
import 'package:flutter_pyday/home/index.dart';
import 'package:flutter_pyday/universal/dev_scaffold.dart';
import 'package:flutter_pyday/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgendaPage extends StatelessWidget {
  static const String routeName = "/agenda";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return DefaultTabController(
      length: 3,
      child: DevScaffold(
        title: Text("Agenda"),
        tabBar: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Tools.multiColors[3],
          labelStyle: TextStyle(
            fontSize: 12,
          ),
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              child: Text("Cloud"),
              icon: Icon(
                FontAwesomeIcons.cloud,
                size: 12,
              ),
            ),
            Tab(
              child: Text("Mobile"),
              icon: Icon(
                FontAwesomeIcons.mobile,
                size: 12,
              ),
            ),
            Tab(
              child: Text("Web & More"),
              icon: Icon(
                FontAwesomeIcons.chrome,
                size: 12,
              ),
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            CloudScreen(
              homeBloc: _homeBloc,
            ),
            MobileScreen(
              homeBloc: _homeBloc,
            ),
            WebScreen(
              homeBloc: _homeBloc,
            ),
          ],
        ),
      ),
    );
  }
}
