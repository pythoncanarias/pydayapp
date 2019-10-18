import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pyday {
  static const String app_name = "PyDayGC 2019";
  static const String app_version = "Version 1.0.0";
  static const int app_version_code = 1;
  static const String app_color = "#ffd7167";
  static Color primaryAppColor = Colors.white;
  static Color secondaryAppColor = Colors.black;
  static const String lato = "Lato";
  static bool isDebugMode = false;

  // * Url related
  static String baseUrl = "https://pythoncanarias.es";

  static checkDebug() {
    assert(() {
      baseUrl = "https://pythoncanarias.es";
      isDebugMode = true;
      return true;
    }());
  }

  static bool get checkDebugBool {
    var debug = false;
    assert(debug = true);

    return debug;
  }

  //* Images
  static const String home_img = "assets/images/banne_light.png";
  static const String banner_light = "assets/images/pyday2019.jpg";
  //*  Texts
  static const String welcomeText = "Bienvenidos a PyDayGC 2019!";
  static const String descText =
      '''PyDay Gran Canaria 2019 es un evento tecnológico organizado por la asociación Python Canarias cuyo principal objetivo es promover el uso del lenguaje de programación Python y servir como punto de encuentro de todas aquellas personas interesadas en el mismo.''';

  static const String loading_text = "Cargando...";
  static const String try_again_text = "Prueba otra vez";
  static const String some_error_text = "Error";
  static const String signInText = "Iniciar sesión";
  static const String signInGoogleText = "Iniciar sesión con Google";
  static const String signOutText = "Cerrar sesión";
  static const String wrongText = "Algo ha salido mal";
  static const String confirmText = "Confirmar";
  static const String supportText = "Support Needed";
  static const String featureText = "Feature Request";
  static const String moreFeatureText = "More Features coming soon.";
  static const String updateNowText =
      "Please update your app for seamless experience.";
  static const String checkNetText =
      "Comprueba que tu conexión a Internet está activa.";

  //* ActionTexts
  static const String agenda_text = "Agenda";
  static const String speakers_text = "Ponentes";
  static const String team_text = "Staff";
  static const String sponsor_text = "Sponsors";
  static const String faq_text = "Asistente";
  static const String map_text = "Ubicación";

  //* Preferences
  static SharedPreferences prefs;
  static const String loggedInPref = "loggedInPref1";
  static const String displayNamePref = "displayNamePref";
  static const String emailPref = "emailPref";
  static const String phonePref = "phonePref";
  static const String photoPref = "photoPref";
  static const String isAdminPref = "isAdminPref";
  static const String darkModePref = "darkModePref";

  //* JSON URLS
  static const String teamsAssetJson = "assets/json/staff.json";
}
