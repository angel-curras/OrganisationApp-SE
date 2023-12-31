import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/controller/course_controller.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/course.dart';
import 'package:organisation_app/settings/environment.dart';

import 'course_controller_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  group('Get all courses: ', () {
    test('Courses are empty', () async {
      /* Arrange */
      // Create the mocked http client.
      final httpClient = MockClient();

      // Create the course controller to be tested.
      CourseController courseController = CourseController(client: httpClient);

      // Define the API URL and the username.
      final String apiUrl = Environment.apiUrl;
      const String username = "test";
      final String requestUrl = '$apiUrl/courses/user/$username';

      // Define the mocked response.
      when(httpClient.get(Uri.parse(requestUrl)))
          .thenAnswer((_) async => http.Response('[]', 200));

      /* Act */
      List<Course> courses =
          await courseController.getAllCoursesForUser(username);

      /* Assert */
      expect(courses, isEmpty);
    }); // end of test 'Courses are empty'

    test('Courses are not empty', () async {
      /* Arrange */
      // Create the mocked http client.
      final httpClient = MockClient();

      // Create the course controller to be tested.
      CourseController courseController = CourseController(client: httpClient);

      // Define the API URL and the username.
      final String apiUrl = Environment.apiUrl;
      const String username = "test";
      final String requestUrl = '$apiUrl/courses/user/$username';

      // Define the mocked response.
      Course expectedCourse = Course(
        id: 1,
        name: 'Test Course',
      );

      // Encode the expected course as JSON.
      String responseBody = json.encode([expectedCourse.toJsonMap()]);
      when(httpClient.get(Uri.parse(requestUrl)))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      /* Act */
      List<Course> courses =
          await courseController.getAllCoursesForUser(username);

      /* Assert */
      expect(courses, isNotEmpty);
      expect(courses.length, equals(1));
      expect(courses[0].id, equals(expectedCourse.id));
      expect(courses[0].name, equals(expectedCourse.name));
    }); // end of test 'Courses are not empty'
  }); // end of group 'Get all courses'

  test('Course update', () async {
    /* Arrange */
    // Create the mocked http client.
    final httpClient = MockClient();

    // Create the course controller to be tested.
    CourseController courseController = CourseController(client: httpClient);

    // Define the mocked response.
    Course expectedCourse = Course(
      id: 1,
      name: 'Test Course',
    );

    // Define the API URL and the username.
    final String apiUrl = Environment.apiUrl;
    int courseId = expectedCourse.id;
    String requestUrl = '$apiUrl/courses/$courseId';

    // Encode the expected course as JSON.
    when(httpClient.put(Uri.parse(requestUrl),
            headers: anyNamed('headers'), body: expectedCourse.toJsonString()))
        .thenAnswer((_) async => http.Response("{}", 200));

    /* Act */
    await courseController.updateCourse(expectedCourse);
  }); // end of test 'Courses are not empty'
// end of group 'Get all courses'
} // end of main()
