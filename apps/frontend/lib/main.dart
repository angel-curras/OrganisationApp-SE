import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organisation_app/routes.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

class OrganisationApp extends StatelessWidget {
  const OrganisationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppSettings()),
      ],
      child: MaterialApp(
        title: 'Organisation App',
        theme: appTheme,
        routes: appRoutes,
        debugShowCheckedModeBanner: false,
      ),
    );
  } // end of build()
} // end of class OrganisationApp

Future<void> setUpApp() async {
  await dotenv.load(fileName: Environment.fileName);
}

Future<void> main() async {
  // Load the environment variables.
  await setUpApp();
  runApp(const OrganisationApp());
}
