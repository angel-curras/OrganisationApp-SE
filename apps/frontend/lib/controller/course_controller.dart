import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organisation_app/model/course.dart';
import 'package:organisation_app/settings/environment.dart';

class CourseController {
  static final _apiUrl = Environment.apiUrl;
  final http.Client _httpClient;

  CourseController(this._httpClient);

  Future<List<Course>> getAllCoursesForUser(String username) async {
    // access REST interface with get request
    final response =
        await _httpClient.get(Uri.parse('$_apiUrl/courses/user/$username'));

    // check response from backend
    if (response.statusCode == 200) {
      return List<Course>.from(json
          .decode(utf8.decode(response.bodyBytes))
          .map((element) => Course.fromJsonMap(element)));
    } else {
      throw Exception('Failed to decode the list of courses.');
    } // end of if
  } // end of getAllCourses()
} // end of class CourseController
