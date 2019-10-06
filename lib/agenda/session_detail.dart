import 'package:flutter/material.dart';
import 'package:flutter_pyday/home/speaker.dart';
import 'package:flutter_pyday/universal/dev_scaffold.dart';
import 'package:flutter_pyday/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionDetail extends StatelessWidget {
  static const String routeName = "/session_detail";
  final Speaker session;

  SessionDetail({Key key, @required this.session}) : super(key: key);

  List<Widget> socialButtons() {
    List<Widget> widgets = new List<Widget>();
    if (session.telegramUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.telegram,
          size: 15,
        ),
        onPressed: () {
          launch(session.telegramUrl);
        },
      ));
    }
    if (session.twitterUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.twitter,
          size: 15,
        ),
        onPressed: () {
          launch(session.twitterUrl);
        },
      ));
    }
    if (session.githubUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.github,
          size: 15,
        ),
        onPressed: () {
          launch(session.githubUrl);
        },
      ));
    }
    if (session.linkedinUrl != null) {
      widgets.add(new IconButton(
        icon: Icon(
          FontAwesomeIcons.linkedinIn,
          size: 15,
        ),
        onPressed: () {
          launch(session.linkedinUrl);
        },
      ));
    }
    return widgets;
  }

  Widget socialActions(context) {
    List<Widget> widgets = this.socialButtons();
    if (this.socialButtons().length > 0) {
      return FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: this.socialButtons(),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    return DevScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Hero(
                  tag: session.speakerImage,
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: Image.asset(session.speakerImage,
                            width: 100, height: 100)
                        .image,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${session.speakerDesc}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 14,
                      color: Tools.multiColors[1],
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${session.sessionTitle}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                session.sessionDesc,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.caption.copyWith(fontSize: 13),
              ),
              SizedBox(
                height: 20,
              ),
              socialActions(context),
            ],
          ),
        ),
      ),
      title: Text(session.speakerName),
    );
  }
}
