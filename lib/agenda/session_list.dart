import 'package:flutter/material.dart';
import 'package:flutter_pyday/agenda/session_detail.dart';
import 'package:flutter_pyday/home/speaker.dart';
import 'package:flutter_pyday/utils/tools.dart';

class SessionList extends StatelessWidget {
  final List<Speaker> allSessions;

  const SessionList({Key key, @required this.allSessions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: allSessions.length,
      itemBuilder: (c, i) {
        // return Text("sdd");
        return Card(
          elevation: 0.0,
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SessionDetail(
                    session: allSessions[i],
                  ),
                ),
              );
            },
            // dense: true,
            trailing: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "${allSessions[i].sessionTotalTime}\n",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: allSessions[i].sessionStartTime,
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
            leading: Hero(
              tag: allSessions[i].speakerImage,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(allSessions[i].speakerImage),
              ),
            ),
            title: RichText(
              text: TextSpan(
                text: "${allSessions[i].sessionTitle}\n",
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                      text: allSessions[i].speakerName,
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontSize: 14,
                            color: Tools.multiColors[1],
                          ),
                      children: []),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
