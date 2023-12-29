import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';

Future<void> setUpEnvironment() async {
  await dotenv.load(fileName: Environment.fileName);
}

Future<SharedPreferences> setUpSharedPreferences() async {
  return await SharedPreferences.getInstance();
}

Future<void> main() async {
  // Load the environment variables.
  await setUpEnvironment();
  SharedPreferences prefs = await setUpSharedPreferences();
  runApp(OrganisationApp(preferences: prefs));
}
