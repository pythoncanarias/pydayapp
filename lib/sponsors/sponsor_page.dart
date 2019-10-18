import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pyday/universal/dev_scaffold.dart';
import 'package:flutter_pyday/utils/pyday.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../home/home_bloc.dart';
import '../home/home_state.dart';

class SponsorPage extends StatelessWidget {
  static const String routeName = "/sponsor";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    var state = _homeBloc.currentState as InHomeState;
    var sponsors = state.sponsorsData.sponsors;
    return DevScaffold(
      body: ListView(
        children: sponsors.map((sponsor) {
          if (sponsor.logo.endsWith("svg")) {
            return new SvgPicture.network("${Pyday.baseUrl}${sponsor.logo}");
          }
          return SponsorImage(
            imgUrl:
            "${Pyday.baseUrl}${sponsor.logo}",
          );
        }).toList(),
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
