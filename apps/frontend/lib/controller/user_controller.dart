import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organisation_app/settings/environment.dart';

import '../model/app_user.dart';

class UserController {
  static final UserController _singleton = UserController._internal();
  static final _apiUrl = Environment.apiUrl;
  static final http.Client _client = http.Client();

  factory UserController() {
    return _singleton;
  }

  UserController._internal() {
    // init things inside this
  }

  Future<List<AppUser>> getAllUsers() async {
    // access REST interface with get request
    final response = await _client.get(Uri.parse('$_apiUrl/items'));

    // check response from backend
    if (response.statusCode == 200) {
      return List<AppUser>.from(json
          .decode(utf8.decode(response.bodyBytes))
          .map((element) => AppUser.fromJson(element)));
    } else {
      throw Exception('Failed to decode the list of users.');
    } // end of if
  } // end of getAllUsers()

  Future<AppUser> getUser(String userName) async {
    // access REST interface with get request
    final response = await _client.get(Uri.parse('$_apiUrl/users/$userName'));

    // check response from backend
    if (response.statusCode == 200) {
      return AppUser.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('User not found.');
    } // end of if
  } // end of getUser()
} // end of class UserController
