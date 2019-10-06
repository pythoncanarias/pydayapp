import 'package:flutter/material.dart';
import 'package:flutter_pyday/agenda/session_list.dart';
import 'package:flutter_pyday/home/index.dart';

class WebScreen extends StatelessWidget {
  final HomeBloc homeBloc;

  const WebScreen({Key key, this.homeBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var state = homeBloc.currentState as InHomeState;
    var sessions = state.speakersData.speakers;
    var webSessions = sessions.where((s) => s.track == "web").toList();
    return SessionList(
      allSessions: webSessions,
    );
  }
}
