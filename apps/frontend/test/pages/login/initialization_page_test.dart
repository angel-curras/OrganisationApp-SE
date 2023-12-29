import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/app_user.dart';
import 'package:organisation_app/pages/home/home_page.dart';
import 'package:organisation_app/pages/login/initialization_page.dart';
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
            home: InitializationPage()));
  }
}

void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  testWidgets('Test: User not stored', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();
    await tester.pumpWidget(
        MainTestAppInitializationPageNoSettings(preferences: testPreferences));
    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('Test: User stored', (tester) async {
    AppUser user = AppUser(
        userName: "testUser",
        fullName: "testPassword",
        userType: UserType.student);
    SharedPreferences.setMockInitialValues({"user": user.toJsonString()});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();
    await tester.pumpWidget(
        MainTestAppInitializationPageNoSettings(preferences: testPreferences));
    expect(find.byType(MyCoursesPage), findsOneWidget);
  });
}
