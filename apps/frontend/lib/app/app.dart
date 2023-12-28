import 'package:flutter/material.dart';
import 'package:organisation_app/app/routes.dart';
import 'package:organisation_app/settings/app_settings.dart';
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
