import 'package:equatable/equatable.dart';
import 'package:flutter_pyday/home/session.dart';
import 'package:flutter_pyday/home/speaker.dart';
import 'package:flutter_pyday/home/team.dart';
import 'package:flutter_pyday/home/track.dart';
import 'package:meta/meta.dart';

import 'location.dart';
import 'sponsor.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([Iterable props]) : super(props);

  /// Copy object for use in action
  HomeState getStateCopy();
}

/// UnInitialized
class UnHomeState extends HomeState {
  @override
  String toString() => 'UnHomeState';

  @override
  HomeState getStateCopy() {
    return UnHomeState();
  }
}

/// Initialized
class InHomeState extends HomeState {
  final SpeakersData speakersData;
  final TracksData sessionsData;
  final SponsorsData sponsorsData;
  final TeamsData teamsData;
  final LocationData locationData;

  InHomeState(
      {@required this.speakersData,
      @required this.sessionsData,
      @required this.sponsorsData,
      @required this.teamsData,
      @required this.locationData})
      : super([speakersData, sessionsData, sponsorsData, teamsData, locationData]);
  @override
  String toString() => 'InHomeState';

  @override
  HomeState getStateCopy() {
    return InHomeState(
        speakersData: this.speakersData,
        sessionsData: this.sessionsData,
        sponsorsData: this.sponsorsData,
        teamsData: this.teamsData);
  }
}

class ErrorHomeState extends HomeState {
  final String errorMessage;

  ErrorHomeState(this.errorMessage);

  @override
  String toString() => 'ErrorHomeState';

  @override
  HomeState getStateCopy() {
    return ErrorHomeState(this.errorMessage);
  }
}
