import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/course.dart';
import 'package:organisation_app/model/weekday.dart';
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

@GenerateMocks([http.Client])
void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  testWidgets('Test: Load empty dialog', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    Course course =
        Course(name: "Test Course", responsible: "Test Responsible");

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: course,
    ));
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(3));
    expect(find.text("Course: "), findsOneWidget);
    expect(find.text(course.name), findsOneWidget);
    expect(find.text("Responsible: "), findsOneWidget);
    expect(find.text(course.responsible), findsOneWidget);
    expect(find.text("0%"), findsOneWidget);
    expect(find.text("Select date"), findsNWidgets(2));
    expect(find.text("Lecture:"), findsOneWidget);
    expect(find.text("Lab:"), findsOneWidget);
    expect(find.text("Day of week: "), findsNWidgets(2));
    expect(find.text("Start time: "), findsNWidgets(2));
    expect(find.text("End time: "), findsNWidgets(2));
    expect(find.text("Select time"), findsNWidgets(4));
    expect(find.byType(ElevatedButton), findsNWidgets(6));
    expect(find.byType(DropdownButtonFormField<Weekday>), findsNWidgets(2));
  });

  testWidgets('Test: Click to course start date', (tester) async {
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
    expect(find.byType(DatePickerDialog), findsOneWidget);
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Click to course end date', (tester) async {
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
    expect(find.byType(DatePickerDialog), findsOneWidget);
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Click to course lecture week day', (tester) async {
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

  testWidgets('Test: Click to course lecture start time', (tester) async {
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
    expect(find.byType(TimePickerDialog), findsOneWidget);
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Click to course lecture end time', (tester) async {
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
    expect(find.byType(TimePickerDialog), findsOneWidget);
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Click to course lab week day', (tester) async {
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

  testWidgets('Test: Click to course lab start time', (tester) async {
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
    expect(find.byType(TimePickerDialog), findsOneWidget);
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Click to course lab end time', (tester) async {
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
    expect(find.byType(TimePickerDialog), findsOneWidget);
    await tester.tap(find.text("OK"));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);
  });

  testWidgets('Test: Click to course update button', (tester) async {
    SharedPreferences.setMockInitialValues({});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    Course expectedCourse = Course(id: 1, name: "test", responsible: "test");

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    int courseId = expectedCourse.id;
    final String requestUrl = '$apiUrl/courses/$courseId';

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    // Define the mocked response.
    when(mockHttpClient.put(Uri.parse(requestUrl),
            headers: anyNamed('headers'), body: expectedCourse.toJsonString()))
        .thenAnswer((_) async => http.Response("{}", 200));

    await tester.pumpWidget(MainTestApp(
      httpClient: mockHttpClient,
      preferences: testPreferences,
      course: expectedCourse,
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
    expect(find.byType(UpdateCourseDialog), findsNothing);
  });
}
