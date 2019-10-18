import 'package:flutter_pyday/home/session.dart';
import 'package:flutter_pyday/home/speaker.dart';
import 'package:flutter_pyday/home/sponsor.dart';
import 'package:flutter_pyday/home/team.dart';
import 'package:flutter_pyday/home/track.dart';
import 'package:flutter_pyday/network/i_client.dart';
import 'package:flutter_pyday/utils/dependency_injection.dart';
import 'package:flutter_pyday/utils/pyday.dart';

import 'location.dart';

abstract class IHomeProvider {
  Future<SpeakersData> getSpeakers();
  Future<TracksData> getSessions();
  Future<SponsorsData> getSponsors();
  Future<TeamsData> getTeams();
  Future<LocationData> getLocation();
}

class HomeProvider implements IHomeProvider {
  IClient _client;

  static final String sponsorsUrl =
      "${Pyday.baseUrl}/api/v1/events/pydaygc19/sponsors/";

  //! Not Working
  static final String sessionsUrl =
      "${Pyday.baseUrl}/api/v1/events/pydaygc19/tracks/";

  static final String locationUrl =
      "${Pyday.baseUrl}/api/v1/venues/cdtic-innovacion-turistica/";

  //! Not Working
  static final String speakersUrl = "${Pyday.baseUrl}/api/v1/events/pydaygc19/speakers/";

  HomeProvider() {
    _client = Injector().currentClient;
  }

  @override
  Future<SpeakersData> getSpeakers() async {
    var result = await _client.getAsync(speakersUrl);
    if (result.networkServiceResponse.success) {
      SpeakersData res = SpeakersData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<TracksData> getSessions() async {
    var result = await _client.getAsync(sessionsUrl);
    if (result.networkServiceResponse.success) {
      TracksData res = TracksData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<SponsorsData> getSponsors() async {
    var result = await _client.getAsync(sponsorsUrl);
    if (result.networkServiceResponse.success) {
      SponsorsData res = SponsorsData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<TeamsData> getTeams() async {
    var result = await _client.getAsync(speakersUrl);
    if (result.networkServiceResponse.success) {
      TeamsData res = TeamsData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<LocationData> getLocation() async {
    var result = await _client.getAsync(locationUrl);
    if (result.networkServiceResponse.success) {
      LocationData res = LocationData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }
}
