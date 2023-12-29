import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/pages/my_courses/my_courses_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';

class InitializationPage extends StatelessWidget {
  final http.Client _client;

  InitializationPage({Key? key, http.Client? client})
      : _client = client ?? http.Client(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSettings appSettings = Provider.of<AppSettings>(context);

    if (appSettings.hasValidUser()) {
      return MyCoursesPage(client: _client);
    }

    return LoginPage(client: _client);
  }
}
