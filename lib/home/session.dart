import 'package:flutter_pyday/home/speaker.dart';

class SessionsData {
  List<Session> sessions;

  SessionsData({this.sessions});

  SessionsData.fromJson(List<dynamic> json) {
      sessions = new List<Session>();
      json.forEach((v) {
        sessions.add(Session.fromJson(v));
      });
  }
}

class Session {
  int sessionId;
  String sessionTitle;
  String sessionDesc;
  String sessionImage;
  String sessionStartTime;
  String sessionTotalTime;
  String sessionLink;
  String speakerName;
  String speakerImage;
  int speakerId;
  String track;
  dynamic speaker;

  Session(
    this.sessionId,
    this.sessionTitle,
    this.sessionDesc,
    this.sessionImage,
    this.sessionStartTime,
    this.sessionTotalTime,
    this.sessionLink,
    this.speakerName,
    this.speakerImage,
    this.speakerId,
    this.track,
    this.speaker
  );

  Session.fromJson(Map<String, dynamic> json) {
    sessionId = json['talk_id'];
    sessionTitle = json['name'];
    sessionDesc = json['description'];
    sessionImage = json['session_image'];
    sessionStartTime = json['start'];
    sessionTotalTime = "50 mins";
    sessionLink = json['session_link'];
    if (json["name"] == "Descanso") {
      speakerName = "";
      speakerImage = "";
      speakerId = 0;
      track = json['track'];
      speaker = {};
    } else {
      speakerName = "${json["speakers"][0]['name']} ${json["speakers"][0]['surname']}";
      speakerImage = json["speakers"][0]['photo'];
      speakerId = json["speakers"][0]['speaker_id'];
      track = json['track'];
      speaker = {};
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    data['session_title'] = this.sessionTitle;
    data['session_desc'] = this.sessionDesc;
    data['session_image'] = this.sessionImage;
    data['session_start_time'] = this.sessionStartTime;
    data['session_total_time'] = this.sessionTotalTime;
    data['session_link'] = this.sessionLink;
    data['speaker_name'] = this.speakerName;
    data['speaker_image'] = this.speakerImage;
    data['speaker_id'] = this.speakerId;
    data['track'] = this.track;
    return data;
  }
}
