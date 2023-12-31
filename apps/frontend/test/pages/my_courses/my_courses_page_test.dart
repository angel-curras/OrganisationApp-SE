import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/app_user.dart';
import 'package:organisation_app/model/course.dart';
import 'package:organisation_app/pages/my_courses/my_courses_page.dart';
import 'package:organisation_app/pages/my_courses/update_course_dialog.dart';
import 'package:organisation_app/settings/app_settings.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_courses_page_test.mocks.dart';

class MainTestAppHomePage extends StatelessWidget {
  final http.Client _client;
  final SharedPreferences _preferences;

  const MainTestAppHomePage(
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
          routes: {
            "/modules": (context) => const Placeholder(),
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
  }); // end of setUp()

  testWidgets('Test: Load empty courses', (tester) async {
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

    await tester.pumpWidget(MainTestAppHomePage(
      httpClient: mockHttpClient,
      preferences: testPreferences,
    ));
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 200));
  });

  testWidgets('Test: Update button', (tester) async {
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

    await tester.pumpWidget(MainTestAppHomePage(
      httpClient: mockHttpClient,
      preferences: testPreferences,
    ));
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await tester.pumpAndSettle();

    // Check that the update button is present.
    expect(find.byIcon(Icons.update), findsOneWidget);
    await tester.tap(find.byIcon(Icons.update));
    await tester.pumpAndSettle();
    expect(find.byType(MyCoursesPage), findsOneWidget);
  });

  testWidgets('Test: Navigate to modules', (tester) async {
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

    await tester.pumpWidget(MainTestAppHomePage(
      httpClient: mockHttpClient,
      preferences: testPreferences,
    ));
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 200));

    // Navigate to Modules
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.byType(Placeholder), findsOneWidget);
  });

  testWidgets('Test: load 2 courses', (tester) async {
    AppUser user = AppUser(
      userName: "test",
      fullName: "Test User",
      userType: UserType.student,
    );
    SharedPreferences.setMockInitialValues({"user": user.toJsonString()});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    const String username = "test";
    final String requestUrl = '$apiUrl/courses/user/$username';

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    // Define the mocked response.
    Course course1 = Course(
      id: 1,
      name: "Course 1",
    );

    Course course2 = Course(
      id: 2,
      name: "Course 2",
    );

    // Define the mocked response.

    // Encode the expected course as JSON.
    String responseBody =
        json.encode([course1.toJsonMap(), course2.toJsonMap()]);
    when(mockHttpClient.get(Uri.parse(requestUrl)))
        .thenAnswer((_) async => http.Response(responseBody, 200));

    await tester.pumpWidget(MainTestAppHomePage(
      httpClient: mockHttpClient,
      preferences: testPreferences,
    ));
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await tester.pumpAndSettle();

    // Find the courses.
    expect(find.byType(ListTile), findsNWidgets(2));
    expect(find.text(course1.name), findsOneWidget);
    expect(find.text(course2.name), findsOneWidget);
  });

  testWidgets('Test: update a course', (tester) async {
    AppUser user = AppUser(
      userName: "test",
      fullName: "Test User",
      userType: UserType.student,
    );
    SharedPreferences.setMockInitialValues({"user": user.toJsonString()});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    const String username = "test";
    final String requestUrl = '$apiUrl/courses/user/$username';

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    // Define the mocked response.
    Course course1 = Course(
      id: 1,
      name: "Course 1",
    );

    // Define the mocked response.
    String responseBody = json.encode([course1.toJsonMap()]);
    when(mockHttpClient.get(Uri.parse(requestUrl)))
        .thenAnswer((_) async => http.Response(responseBody, 200));

    await tester.pumpWidget(MainTestAppHomePage(
      httpClient: mockHttpClient,
      preferences: testPreferences,
    ));
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await tester.pumpAndSettle();

    // Find the courses.
    expect(find.byType(ListTile), findsNWidgets(1));
    expect(find.text(course1.name), findsOneWidget);

    // Update the course.
    await tester.tap(find.text(course1.name));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateCourseDialog), findsOneWidget);

    // Go back.
    await tester.tapAt(const Offset(0.0, 0.0));
    await tester.pumpAndSettle();
    expect(find.byType(MyCoursesPage), findsOneWidget);
  });

  testWidgets('Test: delete a course', (tester) async {
    AppUser user = AppUser(
      userName: "test",
      fullName: "Test User",
      userType: UserType.student,
    );
    SharedPreferences.setMockInitialValues({"user": user.toJsonString()});
    SharedPreferences testPreferences = await SharedPreferences.getInstance();

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    const String username = "test";
    final String getRequest = '$apiUrl/courses/user/$username';

    // Create a mock HTTP client.
    final mockHttpClient = MockClient();

    // Define the mocked response.
    Course course1 = Course(
      id: 1,
      name: "Course 1",
    );

    // Define the mocked response.
    String responseBody = json.encode([course1.toJsonMap()]);
    when(mockHttpClient.get(Uri.parse(getRequest)))
        .thenAnswer((_) async => http.Response(responseBody, 200));

    await tester.pumpWidget(MainTestAppHomePage(
      httpClient: mockHttpClient,
      preferences: testPreferences,
    ));
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await tester.pumpAndSettle();

    // Find the courses.
    expect(find.byType(ListTile), findsNWidgets(1));
    expect(find.text(course1.name), findsOneWidget);

    // Delete the course.
    // Delete response.
    int courseId = course1.id;
    String deleteRequest = '$apiUrl/courses/$courseId';
    when(mockHttpClient.delete(Uri.parse(deleteRequest)))
        .thenAnswer((_) async => http.Response("{}", 200));

    when(mockHttpClient.get(Uri.parse(getRequest)))
        .thenAnswer((_) async => http.Response("[]", 200));

    await tester.tap(find.byKey(const Key("delete")));
    await tester.pumpAndSettle();
    expect(find.byType(MyCoursesPage), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsNWidgets(0));
  });
}
