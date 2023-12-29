import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainTestAppInitializationPageNoSettings extends StatelessWidget {
  final SharedPreferences _preferences;

  const MainTestAppInitializationPageNoSettings(
      {super.key, required SharedPreferences preferences})
      : _preferences = preferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => AppSettings(_preferences)),
        ],
        child: MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
            ),
            home: LoginPage()));
  }
}

void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  group("User not initialized", () {
    // setUp(() async {
    //   AppSettings appSettings = AppSettings();
    //   await appSettings.forgetUser();
    // });

    testWidgets('Test: Initialize widgets', (tester) async {
      SharedPreferences.setMockInitialValues({});
      SharedPreferences testPreferences = await SharedPreferences.getInstance();
      await tester.pumpWidget(MainTestAppInitializationPageNoSettings(
          preferences: testPreferences));
    });
  });
}
