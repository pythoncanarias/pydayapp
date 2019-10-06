import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pyday/home/index.dart';
import 'package:flutter_pyday/home/team.dart';
import 'package:flutter_pyday/universal/dev_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamPage extends StatelessWidget {
  static const String routeName = "/team";

  List<Widget> socialButtons(Team team) {
    List<Widget> widgets = new List<Widget>();
    if (team.telegramUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.telegram,
          size: 15,
        ),
        onPressed: () {
          launch(team.telegramUrl);
        },
      ));
    }
    if (team.twitterUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.twitter,
          size: 15,
        ),
        onPressed: () {
          launch(team.twitterUrl);
        },
      ));
    }
    if (team.githubUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.github,
          size: 15,
        ),
        onPressed: () {
          launch(team.githubUrl);
        },
      ));
    }
    if (team.linkedinUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.linkedinIn,
          size: 15,
        ),
        onPressed: () {
          launch(team.linkedinUrl);
        },
      ));
    }
    return widgets;
  }

  Widget socialActions(context, Team team) {
    if (this.socialButtons(team).length > 0) {
      return FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: this.socialButtons(team),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    var state = _homeBloc.currentState as InHomeState;
    var teams = state.teamsData.teams;
    return DevScaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (c, i) {
          return Card(
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
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: teams[i].image,
                      ),
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
                                teams[i].name,
                                style: Theme.of(context).textTheme.title,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 5,
                                color: Color(0xFFf79f1f),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            teams[i].desc,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            teams[i].contribution,
                            style: Theme.of(context).textTheme.caption,
                          ),
                          socialActions(context, teams[i]),
                        ],
                      ),
                    )
                  ],
                )),
          );
        },
        itemCount: teams.length,
      ),
      title: Text("Staff"),
    );
  }
}
