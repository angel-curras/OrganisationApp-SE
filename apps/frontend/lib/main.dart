import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';

Future<void> setUpEnvironment() async {
  await dotenv.load(fileName: Environment.fileName);
}

Future<void> main() async {
  await setUpEnvironment();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(OrganisationApp(preferences: prefs));
} // end of main()
