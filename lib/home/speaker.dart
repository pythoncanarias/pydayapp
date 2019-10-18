class SpeakersData {
  List<Speaker> speakers;

  SpeakersData({this.speakers});

  SpeakersData.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      speakers = new List<Speaker>();
      json['result'].forEach((v) {
        speakers.add(Speaker.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.speakers != null) {
      data['speakers'] = this.speakers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Speaker {
  String speakerName;
  String speakerDesc;
  String speakerImage;
  String speakerInfo;
  int speakerId;
  String sessionStartTime;
  String sessionTotalTime;
  String sessionDesc;
  String track;
  String fbUrl;
  String twitterUrl;
  String linkedinUrl;
  String githubUrl;
  String telegramUrl;
  String sessionTitle;
  int sessionId;
  String sessionLevel;

  Speaker(
      {this.speakerName,
      this.speakerDesc,
      this.speakerImage,
      this.speakerInfo,
      this.speakerId,
      this.sessionStartTime,
      this.sessionTotalTime,
      this.sessionDesc,
      this.track,
      this.fbUrl,
      this.twitterUrl,
      this.linkedinUrl,
      this.githubUrl,
      this.telegramUrl,
      this.sessionTitle,
      this.sessionId,
      this.sessionLevel});

  Speaker.fromJson(Map<String, dynamic> json) {
    speakerName = "${json['name']} ${json['surname']}";
    speakerDesc = json['bio'];
    speakerImage = json['photo'];
    speakerId = json['speaker_id'];
    sessionId = json['talks'][0]['talk_id'];
    sessionStartTime = json['talks'][0]['start'];
    sessionTotalTime = "50 mins";
    sessionDesc = json['talks'][0]['description'];
    track = json['track'];
    fbUrl = json["social"]['facebook'];
    twitterUrl = json["social"]['twitter'];
    linkedinUrl = json["social"]['linkedin'];
    githubUrl = json["social"]['github'];
    telegramUrl = json["social"]['telegram'];
    sessionTitle = json['talks'][0]['name'];
    sessionLevel = json['talks'][0]['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speaker_name'] = this.speakerName;
    data['speaker_desc'] = this.speakerDesc;
    data['speaker_image'] = this.speakerImage;
    data['speaker_info'] = this.speakerInfo;
    data['speaker_id'] = this.speakerId;
    data['session_start_time'] = this.sessionStartTime;
    data['session_total_time'] = this.sessionTotalTime;
    data['session_desc'] = this.sessionDesc;
    data['track'] = this.track;
    data['fb_url'] = this.fbUrl;
    data['twitter_url'] = this.twitterUrl;
    data['linkedin_url'] = this.linkedinUrl;
    data['github_url'] = this.githubUrl;
    data['speaker_title'] = this.sessionTitle;
    data['session_id'] = this.sessionId;
    data['session_level'] = this.sessionLevel;
    return data;
  }
}
