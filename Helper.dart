import 'dart:convert';

import 'package:flutter/material.dart';

///Loads JSON file contents and return a map
Future<Map<String,dynamic>> loadJsonFileAsMap(BuildContext context, String assetPath) async {
  //Get content of assets as string
  String messageDetailsString =
      await DefaultAssetBundle.of(context).loadString(assetPath);
  //Map the content of  the asset as JSON object
  Map<String, dynamic> mappedMessages = json.decode(messageDetailsString);
  print('MAP $mappedMessages');

  return mappedMessages;
}
