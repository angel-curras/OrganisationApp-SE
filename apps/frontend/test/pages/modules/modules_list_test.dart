import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/app_user.dart';
import 'package:organisation_app/model/module.dart';
import 'package:organisation_app/pages/modules/modules_list.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modules_list_test.mocks.dart';

class MainTestApp extends StatelessWidget {
  final http.Client _client;
  final SharedPreferences _preferences;

  const MainTestApp(
      {super.key,
      required http.Client httpClient,
      required SharedPreferences preferences})
      : _client = httpClient,
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
          home: Scaffold(
            body: CoursesPage(
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
  }); // end of setUp()

  testWidgets('Test: Get one single module', (tester) async {
    AppUser user = AppUser(
      userName: "test",
      fullName: "Test User",
      userType: UserType.student,
    );
    SharedPreferences.setMockInitialValues({"user": user.toJsonString()});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    /* Arrange */

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;

    // Create a mock HTTP client.
    final httpClient = MockClient();

    // Define the mocked response.
    final String requestUrl =
        '$apiUrl/modules?page=0&size=10&sortBy=name&sortDir=asc';

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

    Map<String, dynamic> content = {
      "content": [module.toJson()]
    };

    String responseBody = json.encode(content);

    when(httpClient.get(Uri.parse(requestUrl), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(responseBody, 200));

    // Define the mocked response.

    await tester.pumpWidget(MainTestApp(
      httpClient: httpClient,
      preferences: testPreferences,
    ));
    expect(find.byType(CoursesPage), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 200));

    // Find the module in the list
    expect(find.text(module.name), findsOneWidget);

    /* Act */
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
  });
}
