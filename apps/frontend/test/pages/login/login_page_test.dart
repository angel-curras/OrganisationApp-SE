import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainTestAppLoginPage extends StatelessWidget {
  final SharedPreferences _preferences;

  const MainTestAppLoginPage(
      {super.key, required SharedPreferences preferences})
      : _preferences = preferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppSettings(_preferences))
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

  testWidgets('Test: Initialize widgets', (tester) async {
    // Create a mock HTTP client.
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();
    await tester.pumpWidget(MainTestAppLoginPage(
      preferences: testPreferences,
    ));
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Center), findsNWidgets(3));
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(9));
    expect(find.byType(Image), findsNWidgets(2));
  });
}
