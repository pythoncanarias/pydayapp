import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_pyday/agenda/session_detail.dart';
import 'package:flutter_pyday/home/home_bloc.dart';
import 'package:flutter_pyday/home/home_state.dart';
import 'package:flutter_pyday/home/speaker.dart';
import 'package:flutter_pyday/home/sponsor.dart';
import 'package:flutter_pyday/sponsors/sponsor_page.dart';
import 'package:flutter_pyday/universal/dev_scaffold.dart';
import 'package:flutter_pyday/utils/pyday.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/tools.dart';

class FaqPage extends StatefulWidget {
  static const String routeName = "/faq";
  FaqPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FaqPage createState() => new _FaqPage();

}

class _FaqPage extends State<FaqPage> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    Response("hola");
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Color(0xFFf79f1f)),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                new InputDecoration.collapsed(hintText: "Escriba su mensaje"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle = await AuthGoogle(fileJson: "assets/json/PyDayGC19-5e7887c18d5b.json").build();
    Dialogflow dialogflow =Dialogflow(authGoogle: authGoogle,language: Language.spanish);
    AIResponse response = await dialogflow.detectIntent(query);
    List<dynamic> cards = response.getListMessage().where((v) => v.keys.contains("card")).toList();
    List<dynamic> payload = response.getListMessage().where((v) => v.keys.contains("payload")).toList();
    List<ChatMessage> messages = new List<ChatMessage>();
    if (payload.length > 0) {
      for (var payld in payload) {
        messages.add(
            new ChatMessage(
              title: payld["payload"]["telegram"]["text"],
              subtitle: "",
              name: "Bot",
              type: false,
              imageUrl: "",
              style: "text",
              speaker: {},
              sponsor: {}
            )
        );
      }
    } else {
      var _homeBloc = HomeBloc();
      var state = _homeBloc.currentState as InHomeState;
      var speakers = state.speakersData.speakers;
      var sponsors = state.sponsorsData.sponsors;
      for (var card in cards) {
        CardDialogflow dialog = new CardDialogflow(card);
        List<Speaker> speaker = speakers.where((s) => dialog.title.contains(s.speakerName)).toList();
        List<Sponsor> sponsor = sponsors.where((s) => dialog.title.contains(s.name)).toList();
        if (speaker.length > 0) {
          messages.add(
              new ChatMessage(
                title: dialog.title,
                subtitle: dialog.subtitle,
                name: "Bot",
                type: false,
                imageUrl: dialog.imageUri,
                style: "speaker",
                speaker: speaker[0],
                sponsor: {}
              )
          );
        } else {
          messages.add(
              new ChatMessage(
                title: dialog.title,
                subtitle: dialog.subtitle,
                name: "Bot",
                type: false,
                imageUrl: dialog.imageUri,
                style: "sponsor",
                speaker: {},
                sponsor: sponsor[0]
              )
          );
        }

      }
    }

    for (var msg in messages) {
      setState(() {
        _messages.insert(0, msg);
      });
    }
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      title: text,
      subtitle: "",
      name: "Yo",
      type: true,
      imageUrl: "",
      style: "text",
    );
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);
  }

  @override
  Widget build(BuildContext context) {
    return new DevScaffold(
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            )),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
      title: Text("Asistente"),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.title, this.subtitle, this.name, this.imageUrl, this.type, this.style, this.speaker, this.sponsor});

  final String title;
  final String subtitle;
  final String name;
  final String imageUrl;
  final bool type;
  final String style;
  final dynamic speaker;
  final dynamic sponsor;

  Widget createImage(Sponsor sponsor) {
    if (sponsor.logo.endsWith("svg")) {
      return new SvgPicture.network("${Pyday.baseUrl}${sponsor.logo}");
    }
    return SponsorImage(
      imgUrl:
      "${Pyday.baseUrl}${sponsor.logo}",
    );
  }

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
    } else if (speaker.sessionLevel == 'Básico') {
      return Tools.multiColors[3];
    }
    return Tools.multiColors[2];
  }

  List<Widget> otherMessage(context) {
    if (this.style == "text") {
      return <Widget>[
        new Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: new CircleAvatar(child: Center(child: new Icon(FontAwesomeIcons.robot, color: Colors.black,),), backgroundColor: Color(0xFFf79f1f)),
        ),
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(this.name, style:new TextStyle(fontWeight:FontWeight.bold )),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new MarkdownBody(
                    data: this.title
                ),
              ),
            ],
          ),
        ),
      ];
    } else if (this.style == "speaker") {
      return <Widget>[
        new Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: new CircleAvatar(child: Center(child: new Icon(FontAwesomeIcons.robot, color: Colors.black,),), backgroundColor: Color(0xFFf79f1f)),
        ),
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(this.name, style:new TextStyle(fontWeight:FontWeight.bold )),
              new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionDetail(
                          session: speaker,
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
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "${Pyday.baseUrl}${speaker.speakerImage}",
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
                                  speaker.speakerName,
                                  style: Theme.of(context).textTheme.title,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  height: 5,
                                  color: setLevelColor(speaker),
                                ),
                                Text(
                                  speaker.sessionLevel,
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            speaker.sessionTitle,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        socialActions(context, speaker),
                      ],
                    ),
                  )
                ],
                  )),
              ),
              )
            ],
          ),
        ),
      ];
    } else if (this.style == "sponsor") {
      return <Widget>[
        new Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: new CircleAvatar(child: Center(child: new Icon(FontAwesomeIcons.robot, color: Colors.black,),), backgroundColor: Color(0xFFf79f1f)),
        ),
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(this.name, style:new TextStyle(fontWeight:FontWeight.bold )),
              this.createImage(this.sponsor),
            ],
          ),
        ),
      ];
    }

  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: TextStyle(color: Color(0xFFf79f1f))),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(title),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(child: new Text(this.name[0], style: TextStyle(color: Colors.black,)), backgroundColor: Color(0xFFf79f1f),),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}
