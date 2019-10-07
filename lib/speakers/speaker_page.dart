import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pyday/agenda/session_detail.dart';
import 'package:flutter_pyday/home/home_bloc.dart';
import 'package:flutter_pyday/home/index.dart';
import 'package:flutter_pyday/home/speaker.dart';
import 'package:flutter_pyday/universal/dev_scaffold.dart';
import 'package:flutter_pyday/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SpeakerPage extends StatelessWidget {
  static const String routeName = "/speakers";

  List<Widget> socialButtons(Speaker speaker) {
    List<Widget> widgets = new List<Widget>();
    if (speaker.telegramUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.telegram,
          size: 15,
        ),
        onPressed: () {
          launch(speaker.telegramUrl);
        },
      ));
    }
    if (speaker.twitterUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.twitter,
          size: 15,
        ),
        onPressed: () {
          launch(speaker.twitterUrl);
        },
      ));
    }
    if (speaker.githubUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.github,
          size: 15,
        ),
        onPressed: () {
          launch(speaker.githubUrl);
        },
      ));
    }
    if (speaker.linkedinUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.linkedinIn,
          size: 15,
        ),
        onPressed: () {
          launch(speaker.linkedinUrl);
        },
      ));
    }
    return widgets;
  }

  Widget socialActions(context, Speaker speaker) {
    if (this.socialButtons(speaker).length > 0) {
      return FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: this.socialButtons(speaker),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Color setLevelColor(Speaker speaker) {
    if (speaker.sessionLevel == "Intermedio") {
      return Tools.multiColors[1];
    }
    return Tools.multiColors[3];
  }

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    var state = _homeBloc.currentState as InHomeState;
    var speakers = state.speakersData.speakers;
    return DevScaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (c, i) {
          return new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SessionDetail(
                    session: speakers[i],
                  ),
                ),
              );
            },
            child: Card(
              elevation: 0.0,
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                        child: Image.asset(speakers[i].speakerImage),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  speakers[i].speakerName,
                                  style: Theme.of(context).textTheme.title,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height: 5,
                                  color: setLevelColor(speakers[i]),
                                ),
                                Text(
                                  speakers[i].sessionLevel,
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              speakers[i].sessionTitle,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            socialActions(context, speakers[i]),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          );
        },
        itemCount: speakers.length,
      ),
      title: Text("Ponentes"),
    );
  }
}
