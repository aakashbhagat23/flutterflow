import 'dart:io';

import 'package:url_launcher/url_launcher.dart';
import 'package:json_path/json_path.dart';

Future launchURL(String url) async {
  var uri = Uri.parse(url).toString();
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}

DateTime get getCurrentTimestamp => DateTime.now();

dynamic getJsonField(dynamic response, String jsonPath) {
  final field = JsonPath(jsonPath).read(response);
  return field.isNotEmpty ? field.first.value : null;
}

bool get isIos => Platform.isIOS;
