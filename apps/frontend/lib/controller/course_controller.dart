import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:organisation_app/model/course.dart';
import 'package:organisation_app/settings/environment.dart';
import 'package:universal_html/html.dart';

class CourseController {
  static final Logger _logger = Logger();
  static final _apiUrl = Environment.apiUrl;
  final http.Client _httpClient;

  CourseController({http.Client? client})
      : _httpClient = client ?? http.Client();

  Future<List<Course>> getAllCoursesForUser(String username) async {
    // Get the courses for the user from the REST API.
    String requestUrl = '$_apiUrl/courses/user/$username';
    final response = await _httpClient.get(Uri.parse(requestUrl));
    int statusCode = response.statusCode;

    // Check response from backend.
    List<Course> courses = [];

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
} // end of class CourseController
