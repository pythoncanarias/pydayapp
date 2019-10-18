import 'dart:async';

import 'package:flutter_pyday/home/home_provider.dart';
import 'package:flutter_pyday/home/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc});
}

class LoadHomeEvent extends HomeEvent {
  final IHomeProvider _homeProvider = HomeProvider();
  @override
  String toString() => 'LoadHomeEvent';

  @override
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async {
    try {
      var speakersData = await _homeProvider.getSpeakers();
      var sessionsData = await _homeProvider.getSessions();
      var teamsData = await _homeProvider.getTeams();
      var sponsorsData = await _homeProvider.getSponsors();
      var locationData = await _homeProvider.getLocation();
      return InHomeState(
        speakersData: speakersData,
        sessionsData: sessionsData,
        sponsorsData: sponsorsData,
        teamsData: teamsData,
        locationData: locationData,
      );
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return ErrorHomeState(_?.toString());
    }
  }
}
