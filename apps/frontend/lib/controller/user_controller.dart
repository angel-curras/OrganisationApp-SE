import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:organisation_app/settings/environment.dart';

import '../model/app_user.dart';

class UserController {
  static final _apiUrl = Environment.apiUrl;
  final http.Client _client;

  UserController({required http.Client client}) : _client = client;

  Future<AppUser> getUser(String userName) async {
    // access REST interface with get request
    final response = await _client.get(Uri.parse('$_apiUrl/users/$userName'));

    // check response from backend
    if (response.statusCode == 200) {
      return AppUser.fromJsonMap(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('User not found.');
    } // end of if
  } // end of getUser()
} // end of class UserController
