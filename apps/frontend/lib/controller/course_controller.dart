import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:organisation_app/model/course.dart';
import 'package:organisation_app/model/course_subscription.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:universal_html/html.dart';

class CourseController {
  static final Logger _logger = Logger();
  static final _apiUrl = Environment.apiUrl;
  final http.Client _client;
  static const int _timeout = 3;

  CourseController({http.Client? client}) : _client = client ?? http.Client();

  // Getters
  http.Client get client => _client;

  Future<List<Course>> getAllCoursesForUser(String username) async {
    // Check response from backend.
    List<Course> courses = [];

    // Get the courses for the user from the REST API.
    String requestUrl = '$_apiUrl/courses/user/$username';

    final http.Response response;
    try {
      response = await _client
          .get(Uri.parse(requestUrl))
          .timeout(const Duration(seconds: _timeout));
    } on TimeoutException catch (timeoutException) {
      _logger.e("TimeoutException: ${timeoutException.message}");
      return courses;
    }

    int statusCode = response.statusCode;

    switch (statusCode) {
      case HttpStatus.ok:
        _logger.i("HTTP Status 200: OK. Courses found.");
        try {
          courses = List<Course>.from(json
              .decode(utf8.decode(response.bodyBytes))
              .map((element) => Course.fromJsonMap(element)));
        } catch (exception) {
          _logger.e("Failed to decode the JSON list of courses.");
        }
      case HttpStatus.unauthorized:
        _logger.e("HTTP Status 401: Unauthorized. Username '$username' not "
            "authorized.");

      case HttpStatus.notFound:
        _logger.e("HTTP Status 404: Not Found. Courses not found.");
      default:
        _logger.e(
            "Unhandled HTTP Status $statusCode. Defaulting to empty courses.");
    } // end of switch

    return courses;
  } // end of getAllCourses()

  Future<int> enroll(String userName, int courseId) async {
    CourseSubscription courseSubscription = CourseSubscription(
      moduleId: courseId,
      userName: userName,
    );

    String requestUrl = '$_apiUrl/courses';
    final response = await _client
        .post(
      Uri.parse(requestUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: courseSubscription.toJsonString(),
    )
        .timeout(const Duration(seconds: _timeout), onTimeout: () {
      return http.Response('Error: timeout', HttpStatus.requestTimeout);
    });

    int statusCode = response.statusCode;

    switch (statusCode) {
      case HttpStatus.created:
        _logger
            .i("HTTP Status 201: Created. User '$userName' enrolled in course "
            "'$courseId'.");
        break;
      case HttpStatus.conflict:
        _logger.e("HTTP Status 409: Conflict. User '$userName' already "
            "enrolled in course '$courseId'.");
        break;
      default:
        _logger.e(
            "Unhandled HTTP Status $statusCode. Defaulting to enrollment failure.");
    } // end of switch

    return statusCode;
  } // end of enroll()

  Future<bool> updateCourse(Course course) async {
    _logger.i(
        "Updating course '${course.name}' with course id '${course.id}'.");
    http.Response response = await _client
        .put(Uri.parse('$_apiUrl/courses/${course.id}'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: course.toJsonString())
        .timeout(const Duration(seconds: _timeout), onTimeout: () {
      return http.Response('Error: timeout', HttpStatus.requestTimeout);
    });

    return response.statusCode != HttpStatus.ok;
  }

  Future<bool> deleteCourse(Course course) async {
    _logger
        .i("Deleting course '${course.name}' with course id '${course.id}'.");

    http.Response response = await _client
        .delete(Uri.parse('$_apiUrl/courses/${course.id}'))
        .timeout(const Duration(seconds: _timeout), onTimeout: () {
      return http.Response('Error: timeout', HttpStatus.requestTimeout);
    });

    // check response from backend
    return response.statusCode != HttpStatus.ok;
  }
} // end of class CourseController
