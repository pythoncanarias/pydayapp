import 'package:flutter/material.dart';
import 'package:flutter_pyday/agenda/session_list.dart';
import 'package:flutter_pyday/home/index.dart';

class MobileScreen extends StatelessWidget {
  final HomeBloc homeBloc;

  const MobileScreen({Key key, this.homeBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var state = homeBloc.currentState as InHomeState;
    var sessions = state.speakersData.speakers;
    var mobileSessions = sessions.where((s) => s.track == "mobile").toList();
    return SessionList(
      allSessions: mobileSessions,
    );
  }
}
