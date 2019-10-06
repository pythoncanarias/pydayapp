import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pyday/agenda/agenda_page.dart';
import 'package:flutter_pyday/config/index.dart';
import 'package:flutter_pyday/faq/faq_page.dart';
import 'package:flutter_pyday/home/home_page.dart';
import 'package:flutter_pyday/map/map_page.dart';
import 'package:flutter_pyday/speakers/speaker_page.dart';
import 'package:flutter_pyday/sponsors/sponsor_page.dart';
import 'package:flutter_pyday/team/team_page.dart';
import 'package:flutter_pyday/utils/pyday.dart';

class ConfigPage extends StatefulWidget {
  static const String routeName = "/";
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  ConfigBloc configBloc;

  @override
  void initState() {
    super.initState();
    setupApp();
  }

  setupApp() {
    configBloc = ConfigBloc();
    configBloc.darkModeOn = Pyday.prefs.getBool(Pyday.darkModePref) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => configBloc,
      child: BlocBuilder<ConfigBloc, ConfigState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'PyDayGC19',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              //* Custom Google Font
              fontFamily: Pyday.lato,
              primarySwatch: Colors.red,
              primaryColor: configBloc.darkModeOn ? Colors.black : Colors.white,
              disabledColor: Colors.grey,
              cardColor: configBloc.darkModeOn ? Colors.black : Colors.white,
              canvasColor:
                  configBloc.darkModeOn ? Colors.black : Colors.grey[50],
              brightness:
                  configBloc.darkModeOn ? Brightness.dark : Brightness.light,
              buttonTheme: Theme.of(context).buttonTheme.copyWith(
                  colorScheme: configBloc.darkModeOn
                      ? ColorScheme.dark()
                      : ColorScheme.light()),
              appBarTheme: AppBarTheme(
                elevation: 0.0,
              ),
            ),
            home: HomePage(),
            routes: {
              HomePage.routeName: (context) => HomePage(),
              SpeakerPage.routeName: (context) => SpeakerPage(),
              AgendaPage.routeName: (context) => AgendaPage(),
              SponsorPage.routeName: (context) => SponsorPage(),
              TeamPage.routeName: (context) => TeamPage(),
              FaqPage.routeName: (context) => FaqPage(),
              MapPage.routeName: (context) => MapPage(),
            },
          );
        },
      ),
    );
  }
}
