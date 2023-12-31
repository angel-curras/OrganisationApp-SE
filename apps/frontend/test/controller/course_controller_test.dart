import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:organisation_app/controller/course_controller.dart';
import 'package:organisation_app/main.dart';
import 'package:organisation_app/model/course.dart';
import 'package:organisation_app/model/course_subscription.dart';
import 'package:organisation_app/settings/environment.dart';

import 'course_controller_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  setUp(() async {
    await setUpEnvironment();
  }); // end of setUp()

  group('Get courses', () {
    test('Get courses: empty', () async {
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

      // Get the used client
      expect(httpClient, equals(courseController.client));
    }); // end of test 'Get courses: empty'

    test('Get courses: not empty', () async {
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
    }); // end of test 'Get courses: not empty'

    test('Get courses: JSON decode error', () async {
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
          .thenAnswer((_) async => http.Response('', 200));

      /* Act */
      List<Course> courses =
          await courseController.getAllCoursesForUser(username);

      /* Assert */
      expect(courses, isEmpty);
    }); // end of test 'Get courses: JSON decode error'

    test('Get courses: timeout', () async {
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
          .thenThrow(TimeoutException("TimeoutException"));

      /* Act */
      List<Course> courses =
          await courseController.getAllCoursesForUser(username);

      /* Assert */
      expect(courses, isEmpty);
    }); // end of test 'Get courses: timeout'

    test('Get courses: user unauthorized', () async {
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
          .thenAnswer((_) async => http.Response('[]', 401));

      /* Act */
      List<Course> courses =
          await courseController.getAllCoursesForUser(username);

      /* Assert */
      expect(courses, isEmpty);
    }); // end of test 'Get courses: user unauthorized'

    test('Get courses: course not found', () async {
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
          .thenAnswer((_) async => http.Response('[]', 404));

      /* Act */
      List<Course> courses =
          await courseController.getAllCoursesForUser(username);

      /* Assert */
      expect(courses, isEmpty);
    }); // end of test 'Get courses: course not found'

    test('Get courses: other error', () async {
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
          .thenAnswer((_) async => http.Response('[]', 405));

      /* Act */
      List<Course> courses =
          await courseController.getAllCoursesForUser(username);

      /* Assert */
      expect(courses, isEmpty);
    }); // end of test 'Get courses: other error'
  }); // end of group 'Get courses'

  group('Create courses', () {
    test('Create courses: not empty', () async {
      /* Arrange */
      String username = "test";
      int moduleId = 1;
      CourseSubscription courseSubscription = CourseSubscription(
        moduleId: moduleId,
        userName: username,
      );

      // Create the mocked http client.
      final httpClient = MockClient();

      // Create the course controller to be tested.
      CourseController courseController = CourseController(client: httpClient);

      // Define the API URL and the username.
      final String apiUrl = Environment.apiUrl;
      final String requestUrl = '$apiUrl/courses';

      // Define the mocked response.
      when(httpClient.post(Uri.parse(requestUrl),
              headers: anyNamed("headers"),
              body: courseSubscription.toJsonString()))
          .thenAnswer((_) async => http.Response("{}", 201));

      /* Act */
      int statusCode = await courseController.enroll(username, moduleId);

      /* Assert */
      expect(statusCode, equals(201));
    }); // end of test 'Create courses: not empty'

    test('Create courses: conflict', () async {
      /* Arrange */
      String username = "test";
      int moduleId = 1;
      CourseSubscription courseSubscription = CourseSubscription(
        moduleId: moduleId,
        userName: username,
      );

      // Create the mocked http client.
      final httpClient = MockClient();

      // Create the course controller to be tested.
      CourseController courseController = CourseController(client: httpClient);

      // Define the API URL and the username.
      final String apiUrl = Environment.apiUrl;
      final String requestUrl = '$apiUrl/courses';

      // Define the mocked response.
      when(httpClient.post(Uri.parse(requestUrl),
              headers: anyNamed("headers"),
              body: courseSubscription.toJsonString()))
          .thenAnswer((_) async => http.Response("{}", 409));

      /* Act */
      int statusCode = await courseController.enroll(username, moduleId);

      /* Assert */
      expect(statusCode, equals(409));
    }); // end of test 'Create courses: conflict'

    test('Create courses: other error', () async {
      /* Arrange */
      String username = "test";
      int moduleId = 1;
      CourseSubscription courseSubscription = CourseSubscription(
        moduleId: moduleId,
        userName: username,
      );

      // Create the mocked http client.
      final httpClient = MockClient();

      // Create the course controller to be tested.
      CourseController courseController = CourseController(client: httpClient);

      // Define the API URL and the username.
      final String apiUrl = Environment.apiUrl;
      final String requestUrl = '$apiUrl/courses';

      // Define the mocked response.
      when(httpClient.post(Uri.parse(requestUrl),
              headers: anyNamed("headers"),
              body: courseSubscription.toJsonString()))
          .thenAnswer((_) async => http.Response("{}", 405));

      /* Act */
      int statusCode = await courseController.enroll(username, moduleId);

      /* Assert */
      expect(statusCode, equals(405));
    }); // end of test 'Create courses: other error'

    test('Create courses: timeout', () async {
      /* Arrange */
      String username = "test";
      int moduleId = 1;
      CourseSubscription courseSubscription = CourseSubscription(
        moduleId: moduleId,
        userName: username,
      );

      // Create the mocked http client.
      final httpClient = MockClient();

      // Create the course controller to be tested.
      CourseController courseController = CourseController(client: httpClient);

      // Define the API URL and the username.
      final String apiUrl = Environment.apiUrl;
      final String requestUrl = '$apiUrl/courses';

      // Define the mocked response.
      when(httpClient.post(Uri.parse(requestUrl),
              headers: anyNamed("headers"),
              body: courseSubscription.toJsonString()))
          .thenThrow(TimeoutException("TimeoutException"));

      /* Act */
      int statusCode = await courseController.enroll(username, moduleId);

      /* Assert */
      expect(statusCode, equals(408));
    }); // end of test 'Create courses: other error'
  }); // end of group 'Create courses'

  group('Update courses', () {
    test('Update course: filled', () async {
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
              headers: anyNamed('headers'),
              body: expectedCourse.toJsonString()))
          .thenAnswer((_) async => http.Response("{}", 200));

      /* Act */
      bool result = await courseController.updateCourse(expectedCourse);

      /* Assert */
      expect(result, isTrue);
    }); // end of test 'Update course: filled'

    test('Update course: timeout', () async {
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
              headers: anyNamed('headers'),
              body: expectedCourse.toJsonString()))
          .thenThrow(TimeoutException("TimeoutException"));

      /* Act */
      bool result = await courseController.updateCourse(expectedCourse);

      /* Assert */
      expect(result, isFalse);
    }); // end of test 'Update course: filled'
  }); // end of group 'Update courses'

  group('Delete courses', () {
    test('Delete course: filled', () async {
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
      when(httpClient.delete(Uri.parse(requestUrl)))
          .thenAnswer((_) async => http.Response("{}", 200));

      /* Act */
      bool result = await courseController.deleteCourse(expectedCourse);

      /* Assert */
      expect(result, isTrue);
    }); // end of test 'Delete course: filled'

    test('Delete course: timeout', () async {
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
      when(httpClient.delete(Uri.parse(requestUrl)))
          .thenThrow(TimeoutException("TimeoutException"));

      /* Act */
      bool result = await courseController.deleteCourse(expectedCourse);

      /* Assert */
      expect(result, isFalse);
    }); // end of test 'Delete course: filled'
  }); // end of group 'Delete courses'
} // end of main()
