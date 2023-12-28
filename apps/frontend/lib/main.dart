import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organisation_app/settings/environment.dart';

import 'app/app.dart';

Future<void> setUpApp() async {
  await dotenv.load(fileName: Environment.fileName);
}

Future<void> main() async {
  // Load the environment variables.
  await setUpApp();
  runApp(const OrganisationApp());
}
