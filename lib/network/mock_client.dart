// *  Not needed as of now
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pyday/home/home_provider.dart';
import 'package:flutter_pyday/utils/pyday.dart';

import 'index.dart';

class MockClient implements IClient {
  @override
  Future<MappedNetworkServiceResponse<T>> getAsync<T>(String resourcePath,
      {bool customHeaders}) async {
    var resultClass;
    String rawString;

    //? For Speakers Hardcoded Data
    if (resourcePath == HomeProvider.kConstGetSpeakersUrl) {
      rawString = await rootBundle.loadString(Pyday.speakersAssetJson);
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    //? For Sessions Hardcoded Data
    else if (resourcePath == HomeProvider.kConstGetSessionsUrl) {
      rawString = await rootBundle.loadString(Pyday.speakersAssetJson);
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    //? For Teams Hardcoded Data
    else if (resourcePath == HomeProvider.kConstGetTeamsUrl) {
      rawString = await rootBundle.loadString(Pyday.teamsAssetJson);
      resultClass = await compute(jsonParserIsolate, rawString);
    }

    return MappedNetworkServiceResponse<T>(
        mappedResult: resultClass,
        networkServiceResponse: NetworkServiceResponse<T>(success: true));
  }

  @override
  Future<MappedNetworkServiceResponse<T>> postAsync<T>(
      String resourcePath, data,
      {bool customHeaders = false}) {
    return null;
  }

  // * JSON Decoding using Isolates
  static Map<String, dynamic> jsonParserIsolate(String res) {
    return jsonDecode(res);
  }
}
