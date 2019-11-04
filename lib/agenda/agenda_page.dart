import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pyday/agenda/mobile_screen.dart';
import 'package:flutter_pyday/home/index.dart';
import 'package:flutter_pyday/universal/dev_scaffold.dart';
import 'package:flutter_pyday/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgendaPage extends StatelessWidget {
  static const String routeName = "/agenda";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    var state = _homeBloc.currentState as InHomeState;
    var tracks = state.sessionsData.tracks;
    return DefaultTabController(
      length: tracks.length,
      child: DevScaffold(
        title: Text("Agenda"),
        tabBar: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Tools.multiColors[3],
          labelStyle: TextStyle(
            fontSize: 12,
          ),
          isScrollable: false,
          tabs: tracks.map((track) {
            var icon;
            if (track.name == 'Tatooine') {
              icon = FontAwesomeIcons.rebel;
            } else {
              icon = FontAwesomeIcons.jedi;
            }
            return Tab(
              child: Text(track.name),
              icon: Icon(
                icon,
                size: 12,
              ),
            );
          }).toList(),
        ),
        body: TabBarView(
          children: tracks.map((track) {
            return MobileScreen(
              track: track,
            );
          }).toList(),
        ),
      ),
    );
  }
}
