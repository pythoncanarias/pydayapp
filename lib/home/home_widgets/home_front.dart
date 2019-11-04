import 'package:flutter/material.dart';
import 'package:flutter_pyday/agenda/agenda_page.dart';
import 'package:flutter_pyday/config/index.dart';
import 'package:flutter_pyday/faq/faq_page.dart';
import 'package:flutter_pyday/map/map_page.dart';
import 'package:flutter_pyday/speakers/speaker_page.dart';
import 'package:flutter_pyday/sponsors/sponsor_page.dart';
import 'package:flutter_pyday/team/team_page.dart';
import 'package:flutter_pyday/universal/image_card.dart';
import 'package:flutter_pyday/utils/pyday.dart';
import 'package:flutter_pyday/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFront extends StatelessWidget {
  List<Widget> pyDayTexts(context) => [
        Text(
          Pyday.welcomeText,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          Pyday.descText,
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
      ];

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget newActions(context) => Wrap(
        alignment: WrapAlignment.center,
        spacing: 20.0,
        runSpacing: 20.0,
        children: <Widget>[
          ActionCard(
            icon: Icons.schedule,
            color: Colors.red,
            title: Pyday.agenda_text,
            onPressed: () => Navigator.pushNamed(context, AgendaPage.routeName),
          ),
          ActionCard(
            icon: Icons.person,
            color: Colors.green,
            title: Pyday.speakers_text,
            onPressed: () =>
                Navigator.pushNamed(context, SpeakerPage.routeName),
          ),
          ActionCard(
            icon: Icons.attach_money,
            color: Colors.purple,
            title: Pyday.sponsor_text,
            onPressed: () =>
                Navigator.pushNamed(context, SponsorPage.routeName),
          ),
          ActionCard(
            icon: FontAwesomeIcons.robot,
            color: Colors.brown,
            title: Pyday.faq_text,
            onPressed: () => Navigator.pushNamed(context, FaqPage.routeName),
          ),
          ActionCard(
            icon: Icons.map,
            color: Colors.blue,
            title: Pyday.map_text,
            onPressed: () => Navigator.pushNamed(context, MapPage.routeName),
          )
        ],
      );

  Widget socialActions(context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.twitter),
              onPressed: () async {
                await _launchURL("https://twitter.com/pythoncanarias");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.youtube),
              onPressed: () async {
                await _launchURL(
                    "https://www.youtube.com/channel/UCIH5U0UXk-NL1HdFSo__63A");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.envelope),
              onPressed: () async {
                var emailUrl =
                    '''mailto:info@pythoncanarias.es?subject=Support Needed For PyDay app App&body={Name: Alejandro M. Alberto},Email: alex.23p10@gmail.com}''';
                var out = Uri.encodeFull(emailUrl);
                await _launchURL(out);
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.telegram),
              onPressed: () async {
                await _launchURL("https://t.me/joinchat/AJ7pmT-X0xZVPgWDIzGA-A");
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ImageCard(
              img: Pyday.banner_light,
            ),
            SizedBox(
              height: 20,
            ),
            ...pyDayTexts(context),
            SizedBox(
              height: 20,
            ),
            newActions(context),
            SizedBox(
              height: 20,
            ),
            socialActions(context),
            SizedBox(
              height: 20,
            ),
            Text(
              Pyday.app_version,
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String title;
  final Color color;

  const ActionCard({Key key, this.onPressed, this.icon, this.title, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPressed,
      child: Ink(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: ConfigBloc().darkModeOn
              ? Tools.hexToColor("#1f2124")
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: !ConfigBloc().darkModeOn
              ? [
                  BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
