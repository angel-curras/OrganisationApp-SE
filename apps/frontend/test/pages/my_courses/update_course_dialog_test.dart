import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/course.dart';
import 'package:organisation_app/pages/my_courses/update_course_dialog.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'update_course_dialog_test.mocks.dart';

class MainTestApp extends StatelessWidget {
  final http.Client _client;
  final SharedPreferences _preferences;
  final Course _course;

  const MainTestApp(
      {super.key,
      required http.Client httpClient,
      required SharedPreferences preferences,
      required Course course})
      : _client = httpClient,
        _preferences = preferences,
        _course = course;

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
            body: UpdateCourseDialog(
              client: _client,
              course: _course,
            ),
          ),
        ));
  }
}

@GenerateNiceMocks([MockSpec<http.Client>(as: #MockClient)])
void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  testWidgets('Test: Load empty dialog', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    Course course = Course();

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Load empty dialog', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    const String username = "test";
    final String requestUrl = '$apiUrl/courses/user/$username';

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    // Define the mocked response.
    when(mockHttpClient.get(Uri.parse(requestUrl)))
        .thenAnswer((_) async => http.Response('[]', 200));

    Course course = Course();

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Start date', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    Course course = Course();

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);

    await tester.tap(find.byKey(const Key("startDateButton")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: End date', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    Course course = Course();

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);

    await tester.tap(find.byKey(const Key("endDateButton")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Lecture week day', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    Course course = Course();

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);

    await tester.tap(find.byKey(const Key("lectureWeekDayDropdownButton")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("MONDAY"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Lecture start time', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    Course course = Course();

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);

    await tester.tap(find.byKey(const Key("lectureStartTimeButton")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Lecture end time', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    Course course = Course();

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);

    await tester.tap(find.byKey(const Key("lectureEndTimeButton")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Lab week day', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    Course course = Course();

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);

    final expectedWidget = find.byKey(const Key("lectureEndTimeButton"));

    // Scroll until the widget is visible.
    await tester.dragUntilVisible(
        expectedWidget, // what you want to find
        find.byType(ListView),
        // widget you want to scroll
        const Offset(0, 500) // delta to move
        );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("labWeekDayDropdownButton")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("MONDAY"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Lab start time', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    Course course = Course();

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);

    // Find the last visible widget.
    final expectedWidget = find.byKey(const Key("lectureEndTimeButton"));

    // Scroll until the widget is visible.
    await tester.dragUntilVisible(
        expectedWidget, // what you want to find
        find.byType(ListView),
        // widget you want to scroll
        const Offset(0, 500) // delta to move
        );

    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("labStartTimeButton")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Lab end time', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    Course course = Course();

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);

    // Find the last visible widget.
    final expectedWidget = find.byKey(const Key("lectureEndTimeButton"));

    // Scroll until the widget is visible.
    await tester.dragUntilVisible(
        expectedWidget, // what you want to find
        find.byType(ListView),
        // widget you want to scroll
        const Offset(0, 500) // delta to move
        );

    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("labEndTimeButton")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Update button', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    const String courseId = "test";
    final String requestUrl = '$apiUrl/courses/$courseId';

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();
    Course course = Course(id: 1, name: "test", responsible: "test");

    // Define the mocked response.
    when(mockHttpClient.put(
      Uri.parse(requestUrl),
      headers: anyNamed('headers'),
      body: anyNamed('body'),
      encoding: null,
    )).thenAnswer((_) async => http.Response("", 200));

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);

    // Find the last visible widget.
    final expectedWidget = find.byKey(const Key("lectureEndTimeButton"));

    // Scroll until the widget is visible.
    await tester.dragUntilVisible(
        expectedWidget, // what you want to find
        find.byType(ListView),
        // widget you want to scroll
        const Offset(0, 500) // delta to move
        );

    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("updateButton")));
    await tester.pumpAndSettle();
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });
}
