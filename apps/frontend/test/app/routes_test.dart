import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/app/routes.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/pages/chatgpt/chatgpt_page.dart';
import 'package:organisation_app/pages/login/login_page.dart';
import 'package:organisation_app/pages/modules/modules_list.dart';
import 'package:organisation_app/pages/moodle/moodle_page.dart';
import 'package:organisation_app/pages/my_courses/my_courses_page.dart';
import 'package:organisation_app/pages/primuss/primuss_page.dart';
import 'package:organisation_app/pages/todos/todos_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../shared/mock_web_view_plattform.dart';
import "routes_test.mocks.dart";

class MainTestApp extends StatelessWidget {
  final http.Client _client;
  final SharedPreferences _preferences;

  const MainTestApp(
      {super.key,
      required http.Client client,
      required SharedPreferences preferences})
      : _client = client,
        _preferences = preferences;

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
          routes: {
            '/my_courses': (context) => MyCoursesPage(
                  client: _client,
                ),
            '/login': (context) => LoginPage(client: _client),
            '/modules': (context) => CoursesPage(client: _client),
            '/todos': (context) => TodosPage(client: _client),
            '/moodle': (context) => MoodlePage(),
            '/chatgpt': (context) => ChatGptPage(),
            '/primuss': (context) => PrimussPage(),
          },
          home: Scaffold(
            body: MyCoursesPage(
              client: _client,
            ),
          ),
        ));
  }
}

@GenerateMocks([http.Client])
void main() {
  setUp(() async {
    await setUpEnvironment();
    WebViewPlatform.instance = MockWebViewPlatform();
  }); // end of setUp()
  group('Routes tests', () {
    // Define the test parameters
    final testCases = [
      {'route_name': "/init", 'widget_class': "InitializationPage"},
      {'route_name': "/login", 'widget_class': "LoginPage"},
      {'route_name': '/my_courses', 'widget_class': "MyCoursesPage"},
      {'route_name': '/modules', 'widget_class': "CoursesPage"},
      {'route_name': '/todos', 'widget_class': "TodosPage"},
      {'route_name': '/moodle', 'widget_class': "MoodlePage"},
      {'route_name': '/chatgpt', 'widget_class': "ChatGptPage"},
      {'route_name': '/primuss', 'widget_class': "PrimussPage"},
    ];

    // Iterate over test parameters and create individual tests
    for (final testCase in testCases) {
      test('Testing route: ${testCases.indexOf(testCase) + 1}', () {
        // Extract input and expected values
        final routeName = testCase['route_name'] as String;
        final String? expectedWidgetType = testCase['widget_class'];

        var route = appRoutes[routeName];
        expect(route, isNotNull);
        expect(route, isA<Widget Function(BuildContext)>());

        var widget = route!(null);
        expect(widget, isNotNull);
        expect(widget.runtimeType.toString(), expectedWidgetType);
      });
    }
  }); // end of group 'Routes tests'

  group("Navigation test", () {
    testWidgets('Test: Navigation', (tester) async {
      SharedPreferences.setMockInitialValues({});
      SharedPreferences testPreferences = await SharedPreferences.getInstance();

      MockClient mockHttpClient = MockClient();
      await tester.pumpWidget(
          MainTestApp(preferences: testPreferences, client: mockHttpClient));
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
      final String apiUrl = Environment.apiUrl;
      final String requestUrl =
          '$apiUrl/modules?page=0&size=10&sortBy=name&sortDir=asc';

      when(mockHttpClient.get(Uri.parse(requestUrl),
              headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('{ "content": []}', 200));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('modulesTile')));
      await tester.pumpAndSettle();
      expect(find.byType(CoursesPage), findsOneWidget);

      // Navigate to Login
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('logoutTile')));
      await tester.pumpAndSettle();
    });
  });

  tearDown(() {
    // This function is called after each test.
  }); // end of tearDown()
}
