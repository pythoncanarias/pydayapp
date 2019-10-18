import 'package:flutter/material.dart';
import 'package:flutter_pyday/agenda/session_list.dart';
import 'package:flutter_pyday/home/index.dart';
import 'package:flutter_pyday/home/track.dart';

class MobileScreen extends StatelessWidget {
  final Track track;

  const MobileScreen({Key key, this.track}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SessionList(
      allSessions: track.schedule.sessions,
    );
  }
}
