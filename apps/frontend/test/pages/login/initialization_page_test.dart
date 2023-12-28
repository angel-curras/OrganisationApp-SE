import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';

class MainTestAppInitializationPageNoSettings extends StatelessWidget {
  const MainTestAppInitializationPageNoSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppSettings()),
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
    await setUpApp();
  }); // end of setUp()

  group("User not initialized", () {
    // setUp(() async {
    //   AppSettings appSettings = AppSettings();
    //   await appSettings.forgetUser();
    // });

    testWidgets('Test: Initialize widgets', (tester) async {
      await tester.pumpWidget(const MainTestAppInitializationPageNoSettings());
    });
  });
}
