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
  final http.Client _httpClient;
  static const int _timeout = 3;

  CourseController({http.Client? client})
      : _httpClient = client ?? http.Client();

  Future<List<Course>> getAllCoursesForUser(String username) async {
    // Check response from backend.
    List<Course> courses = [];

    // Get the courses for the user from the REST API.
    String requestUrl = '$_apiUrl/courses/user/$username';

    final http.Response response;
    try {
      response = await _httpClient
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
    final response = await _httpClient
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
} // end of class CourseController
