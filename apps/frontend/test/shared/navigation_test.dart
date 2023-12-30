import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organisation_app/app/routes.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/pages/chatgpt/chatgpt_page.dart';
import 'package:organisation_app/pages/moodle/moodle_page.dart';
import 'package:organisation_app/pages/my_courses/my_courses_page.dart';
import 'package:organisation_app/pages/primuss/primuss_page.dart';
import 'package:organisation_app/pages/todos/todos_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'mock_web_view_plattform.dart';

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
          initialRoute: '/my_courses',
        ));
  }
}

void main() {
  setUp(() async {
    await setUpEnvironment();
    WebViewPlatform.instance = MockWebViewPlatform();
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

    // Navigate to Moodle
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('moodleTile')));
    await tester.pumpAndSettle();
    expect(find.byType(MoodlePage), findsOneWidget);

    // Navigate to Primuss
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('primussTile')));
    await tester.pumpAndSettle();
    expect(find.byType(PrimussPage), findsOneWidget);

    // Navigate to ChatGpt
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('chatgptTile')));
    await tester.pumpAndSettle();
    expect(find.byType(ChatGptPage), findsOneWidget);

    // Navigate to Modules
    // TODO: Test when the exceptions are removed.
    // await tester.tap(find.byIcon(Icons.menu));
    // await tester.pumpAndSettle();
    // await tester.tap(find.byKey(const Key('modulesTile')));
    // await tester.pumpAndSettle();
    // expect(find.byType(CoursesPage), findsOneWidget);

    // Navigate to Login
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('logoutTile')));
    await tester.pumpAndSettle();
  });
}
