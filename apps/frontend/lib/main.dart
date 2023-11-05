import 'package:flutter/material.dart';
import 'package:organisation_app/routes.dart';

import 'theme.dart';

void main() {
  runApp(const OrganisationApp());
}

class OrganisationApp extends StatelessWidget {
  const OrganisationApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organisation App',
      theme: appTheme,
      routes: appRoutes,
    );
  }
}
