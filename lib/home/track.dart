import 'package:flutter_pyday/home/session.dart';

class TracksData {
  List<Track> tracks;

  TracksData({this.tracks});

  TracksData.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      tracks = new List<Track>();
      json['result'].forEach((v) {
        tracks.add(Track.fromJson(v));
      });
    }
  }
}

class Track {
  String name;
  SessionsData schedule;

  Track({
    this.name,
    this.schedule,
  });

  Track.fromJson(Map<String, dynamic> json) {
    schedule = SessionsData.fromJson(json["schedule"]);
    name = json['name'];
  }
}
