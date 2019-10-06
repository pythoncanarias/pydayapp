import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pyday/universal/dev_scaffold.dart';

class SponsorPage extends StatelessWidget {
  static const String routeName = "/sponsor";

  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    return DevScaffold(
      body: ListView(
        children: <Widget>[
          SponsorImage(
            imgUrl:
                "https://intelygenz.com/wp-content/uploads/2019/05/OpenGraphs_WEB_Core.png",
          ),
          SizedBox(
            height: 30,
          ),
          SponsorImage(
            imgUrl:
                "https://www.wtmgrancanaria.com/wp-content/uploads/logo_edosoft.png",
          ),
          SizedBox(
            height: 30,
          ),
          SponsorImage(
            imgUrl:
                "https://cdn-images-1.medium.com/max/1200/1*nmg8j93sd6J7adrjt0gJGg.jpeg",
          ),
        ],
      ),
      title: Text("Sponsors"),
    );
  }
}

class SponsorImage extends StatelessWidget {
  final String imgUrl;

  const SponsorImage({Key key, this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          height: 200.0,
          width: 200.0,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
