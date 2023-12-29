import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/routes.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/pages/home/home_page.dart';
import 'package:organisation_app/pages/todos/todos_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainTestAppNavigation extends StatelessWidget {
  final SharedPreferences _preferences;

  const MainTestAppNavigation(
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
          routes: appRoutes,
          initialRoute: '/home',
        ));
  }
}

void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  testWidgets('Test: Navigation', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();
    await tester
        .pumpWidget(MainTestAppNavigation(preferences: testPreferences));
    await tester.pumpAndSettle();

    // Navigate to My Courses
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('homeTile')));
    await tester.pumpAndSettle();
    expect(find.byType(MyCoursesPage), findsOneWidget);

    // Navigate to ToDos
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('todosTile')));
    await tester.pumpAndSettle();
    expect(find.byType(TodosPage), findsOneWidget);

    // Navigate to Login
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('logoutTile')));
    await tester.pumpAndSettle();
  });
}
