import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pyday/utils/dependency_injection.dart';
import 'package:flutter_pyday/utils/pyday.dart';
import 'package:flutter_pyday/utils/simple_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/config_page.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  //* Forcing only portrait orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // * Get Shared Preference Instance for whole app
  Pyday.prefs = await SharedPreferences.getInstance();

  //* To check the app is running in debug and set some variables for that
  Pyday.checkDebug();

  //* Time travel debugging to check app states
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // * Set flavor for your app. For eg - MOCK for offline, REST for some random server calls to your backend, FIREBASE for firebase calls
  //* Set DataMode.DART to use Dart hardcoded data and DataMode.JSON to use json file for hardcoded data.
  Injector.configure(DataMode.JSON);

  runApp(ConfigPage());
}
