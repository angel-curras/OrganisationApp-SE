import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/app_user.dart';
import 'package:organisation_app/model/course_subscription.dart';
import 'package:organisation_app/model/module.dart';
import 'package:organisation_app/pages/modules/module_details_page.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "module_details_page_test.mocks.dart";

class MainTestAppHomePage extends StatelessWidget {
  final Module _module;
  final http.Client _client;
  final SharedPreferences _preferences;

  const MainTestAppHomePage(
      {super.key,
      required http.Client httpClient,
      required SharedPreferences preferences,
      required Module module})
      : _client = httpClient,
        _preferences = preferences,
        _module = module;

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
            "/modules": (context) => const Placeholder(),
          },
          home: Scaffold(
            body: ModuleDetailsPage(
              client: _client,
              module: _module,
            ),
          ),
        ));
  }
}

@GenerateMocks([http.Client])
void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  testWidgets('Test: Press enroll button (success)', (tester) async {
    AppUser user = AppUser(
      userName: "test",
      fullName: "Test User",
      userType: UserType.student,
    );
    SharedPreferences.setMockInitialValues({"user": user.toJsonString()});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    /* Arrange */
    String username = "test";
    Module module = Module(
      id: 1,
      name: "Test Module",
      ects: 5,
      sws: 2,
      verantwortlich: "Test",
      sprachen: "DE",
      lehrform: "Test",
      angebot: "Test",
      aufwand: "Test",
      voraussetzungen: "Test",
      ziele: "Test",
      inhalt: "Test",
      medienUndMethoden: "Test",
      literatur: "Test",
      zpaId: 1,
      anzahlSprachen: 2,
      url: 'test',
    );

    CourseSubscription courseSubscription = CourseSubscription(
      moduleId: module.id,
      userName: username,
    );

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;

    // Create a mock HTTP client.
    final httpClient = MockClient();

    // Define the mocked response.
    final String requestUrl = '$apiUrl/courses';

    // Define the mocked response.
    when(httpClient.post(Uri.parse(requestUrl),
            headers: anyNamed("headers"),
            body: courseSubscription.toJsonString()))
        .thenAnswer((_) async => http.Response("{}", 201));

    await tester.pumpWidget(MainTestAppHomePage(
      httpClient: httpClient,
      preferences: testPreferences,
      module: module,
    ));
    expect(find.byType(ModuleDetailsPage), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 200));

    /* Act */
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
  }); // end of test 'Test: Press enroll button (success)'
}
