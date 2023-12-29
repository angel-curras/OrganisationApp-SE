import 'package:flutter/material.dart';
import 'package:organisation_app/app/routes.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme.dart';

class OrganisationApp extends StatelessWidget {
  final SharedPreferences _preferences;

  const OrganisationApp({super.key, required SharedPreferences preferences})
      : _preferences = preferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppSettings(_preferences)),
      ],
      child: MaterialApp(
        title: 'Organisation App',
        theme: appTheme,
        routes: appRoutes,
        initialRoute: '/init',
        debugShowCheckedModeBanner: false,
      ),
    );
  } // end of build()
} // end of class OrganisationApp
