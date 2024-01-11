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
import 'package:organisation_app/controller/module_controller.dart';

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

class MockModuleController extends Mock implements ModuleController {
  bool shouldThrowError = false;

  List<Module> generateMockModules(int count) {
    return List.generate(
        count,
        (index) => Module(
              id: index,
              name: "Test Module $index",
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
            ));
  }

  @override
  Future<List<Module>> fetchModuleListWithPaginationAndSorting(
    http.Client client, {
    int page = 0,
    int size = 10,
    String sortBy = 'name',
    String sortDir = 'asc',
    String searchQuery = '',
  }) async {
    if (shouldThrowError) {
      throw Exception('Error: Mocked error');
    }
    // Return your mock data here
    return generateMockModules(100);
  }
}

@GenerateMocks([http.Client])
void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  group('ModuleList Tests', () {
    late MockClient mockClient;
    late MockModuleController mockBackend;

    // Test overall functionality of ModuleSearchDelegate
    setUp(() {
      mockClient = MockClient();
      mockBackend = MockModuleController();
    });

    testWidgets('Test: Get one single module', (tester) async {
      AppUser user = AppUser(
        userName: "test",
        fullName: "Test User",
        userType: UserType.student,
      );
      SharedPreferences.setMockInitialValues({"user": user.toJsonString()});
      SharedPreferences testPreferences = await SharedPreferences.getInstance();

      // Define the mocked response as a JSON string.
      final jsonResponse = jsonEncode({
        "content": List.generate(
            10,
            (index) => {
                  "id": index,
                  "name": "Test Module $index",
                  "ects": 5,
                  "sws": 2,
                  "verantwortlich": "Test",
                  "sprachen": "DE",
                  "lehrform": "Test",
                  "angebot": "Test",
                  "aufwand": "Test",
                  "voraussetzungen": "Test",
                  "ziele": "Test",
                  "inhalt": "Test",
                  "medienUndMethoden": "Test",
                  "literatur": "Test",
                  "zpaId": 1,
                  "anzahlSprachen": 2,
                  "url": 'test',
                })
      });

      // Mock the HTTP response
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      // Pump the widget
      await tester.pumpWidget(MainTestApp(
        httpClient: mockClient,
        preferences: testPreferences,
      ));
      expect(find.byType(CoursesPage), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 200));

      // Find the module in the list
      expect(find.text('Test Module 1'), findsOneWidget);

      /* Act */
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Tap "Sort by Name"
      await tester.tap(find.text('Sort by Name'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Tap "Sort by Verantwortlich"
      await tester.tap(find.text('Sort by Verantwortlich'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Tap "Sort by ECTS"
      await tester.tap(find.text('Sort by ECTS'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // Tap "Sort by Lehrform"
      await tester.tap(find.text('Sort by Lehrform'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      // // Tap ascending toggle
      await tester.tap(find.byType(SwitchListTile));
      await tester.pumpAndSettle();
    });

    testWidgets('Test: Tap Load More button', (tester) async {
      AppUser user = AppUser(
        userName: "test",
        fullName: "Test User",
        userType: UserType.student,
      );
      SharedPreferences.setMockInitialValues({"user": user.toJsonString()});
      SharedPreferences testPreferences = await SharedPreferences.getInstance();

      // Define the mocked response as a JSON string.
      final jsonResponse = jsonEncode({
        "content": List.generate(
            10,
            (index) => {
                  "id": index,
                  "name": "Test Module $index",
                  "ects": 5,
                  "sws": 2,
                  "verantwortlich": "Test",
                  "sprachen": "DE",
                  "lehrform": "Test",
                  "angebot": "Test",
                  "aufwand": "Test",
                  "voraussetzungen": "Test",
                  "ziele": "Test",
                  "inhalt": "Test",
                  "medienUndMethoden": "Test",
                  "literatur": "Test",
                  "zpaId": 1,
                  "anzahlSprachen": 2,
                  "url": 'test',
                })
      });

      // Mock the HTTP response
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      await tester.pumpWidget(MainTestApp(
        httpClient: mockClient,
        preferences: testPreferences,
      ));
      expect(find.byType(CoursesPage), findsWidgets);
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      final Finder loadMoreButton = find.text('Load More');

      await tester.scrollUntilVisible(
        loadMoreButton,
        500.0, // Scroll amount, adjust as necessary
        scrollable: find.byType(Scrollable),
      );
      await tester.pumpAndSettle();

      // Find the load more button text 'Load More'
      expect(find.text('Load More'), findsOneWidget);

      // Press the load more button
      await tester.tap(find.text('Load More'));

      await tester.pumpAndSettle();
    });

    testWidgets('Test: Tap on Course card', (tester) async {
      AppUser user = AppUser(
        userName: "test",
        fullName: "Test User",
        userType: UserType.student,
      );
      SharedPreferences.setMockInitialValues({"user": user.toJsonString()});
      SharedPreferences testPreferences = await SharedPreferences.getInstance();

      // Define the mocked response as a JSON string.
      final jsonResponse = jsonEncode({
        "content": List.generate(
            10,
            (index) => {
                  "id": index,
                  "name": "Test Module $index",
                  "ects": 5,
                  "sws": 2,
                  "verantwortlich": "Test",
                  "sprachen": "DE",
                  "lehrform": "Test",
                  "angebot": "Test",
                  "aufwand": "Test",
                  "voraussetzungen": "Test",
                  "ziele": "Test",
                  "inhalt": "Test",
                  "medienUndMethoden": "Test",
                  "literatur": "Test",
                  "zpaId": 1,
                  "anzahlSprachen": 2,
                  "url": 'test',
                })
      });

      // Mock the HTTP response
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      await tester.pumpWidget(MainTestApp(
        httpClient: mockClient,
        preferences: testPreferences,
      ));
      expect(find.byType(CoursesPage), findsWidgets);
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      // Tap on a course card
      await tester.tap(find.byType(Card).first);
      await tester.pumpAndSettle();
    });

    testWidgets('Test: Tap on Search', (tester) async {
      AppUser user = AppUser(
        userName: "test",
        fullName: "Test User",
        userType: UserType.student,
      );
      SharedPreferences.setMockInitialValues({"user": user.toJsonString()});
      SharedPreferences testPreferences = await SharedPreferences.getInstance();

      // Define the mocked response as a JSON string.
      final jsonResponse = jsonEncode({
        "content": List.generate(
            10,
            (index) => {
                  "id": index,
                  "name": "Test Module $index",
                  "ects": 5,
                  "sws": 2,
                  "verantwortlich": "Test",
                  "sprachen": "DE",
                  "lehrform": "Test",
                  "angebot": "Test",
                  "aufwand": "Test",
                  "voraussetzungen": "Test",
                  "ziele": "Test",
                  "inhalt": "Test",
                  "medienUndMethoden": "Test",
                  "literatur": "Test",
                  "zpaId": 1,
                  "anzahlSprachen": 2,
                  "url": 'test',
                })
      });

      // Mock the HTTP response
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(jsonResponse, 200));

      await tester.pumpWidget(MainTestApp(
        httpClient: mockClient,
        preferences: testPreferences,
      ));
      expect(find.byType(CoursesPage), findsWidgets);
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();

      // Tap on search
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
    });
  }); // end of group 'ModuleList Tests'
}
